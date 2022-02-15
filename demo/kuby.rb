require "kuby/azure"
require "kuby/kind"

# Define a production Kuby deploy environment
Kuby.define("ViewComponentsStorybook") do
  shared = -> do
    docker do
      credentials do
        username "GitHubActions"
        password ENV["AZURE_ACR_PASSWORD"]
      end

      image_url "primer.azurecr.io/primer/view_components_storybook"

      # Run bundler, yarn, etc in this directory.
      app_root "./demo"

      # Copy over this separate gemfile our main Gemfile depends on. We use a
      # separate gemfile for Kuby dependencies in order to be able to run Kuby
      # commands (i.e. via bin/kuby) without loading the entire bundle.
      bundler_phase.gemfiles "gemfiles/kuby.gemfile"

      # Necessary because our Kuby dependencies are all listed in the separate
      # gemfiles/kuby.gemfile, meaning Kuby can't automatically detect the presence
      # of the Puma webserver. Hopefully this will be fixed in an upcoming Kuby
      # release.
      webserver_phase.webserver = :puma

      # Additional environment variables the app needs when it runs.
      app_phase.env "RAILS_SERVE_STATIC_FILES", "true"
      app_phase.env "RAILS_LOG_TO_STDOUT", "true"

      # We need newer versions than the ones Kuby installs by default.
      package_phase.remove :nodejs
      package_phase.add :nodejs, "16.13.2"

      package_phase.remove :yarn
      package_phase.add :yarn, "1.22.17"

      # Kuby copies over only Gemfiles, i.e. no app code, before attempting to
      # bundle install to prevent busting the layer cache and having to reinstall
      # the entire bundle whenever any app code changes. Our Gemfile includes a
      # relative path to the view_components gem, meaning bundle install will look
      # for primer_view_components.gemspec and blow up if it doesn't exist. In
      # addition, bundler will load and evaluate primer_view_components.gemspec,
      # which itself requires version.rb. Rather than blindy copying over all the
      # code and busting the layer cache, we copy over only these two necessary
      # files before bundle install.
      insert :gem_support, before: :bundler_phase do |dockerfile|
        files = %w(
          primer_view_components.gemspec
          lib/primer/view_components/version.rb
        )

        files.each { |f| dockerfile.copy(f, f) }
      end

      # Unfortunately there are two sets of JavaScript modules our project needs.
      # The first one lives at the top level and is used to compile and bundle up
      # all the JavaScript and TypeScript files included with our component library.
      # The second lives inside the demo/ folder and accompanies the Rails app.
      # Kuby will handle installing JavaScript modules inside demo/, since we
      # specified an app_root of demo/ above. However, it will not install anything
      # defined in the top level package.json, which is where the custom build phase
      # below comes into play. First, we copy over all the individual files yarn
      # needs to 1) install modules, and 2) run the prepare script (see the scripts
      # section in package.json). Side note: apparently yarn will automatically
      # run any script named "prepare" on install if one is defined. Second, we
      # run yarn install at the top level. This custom build phase must be inserted
      # before the Rails app's JavaScript modules are installed (i.e. before
      # :yarn_phase) because the prepare script compiles and generates the PVC
      # JavaScript bundle the Rails app needs to build into its own bundle.
      insert :main_yarn, before: :yarn_phase do |dockerfile|
        files = %w(
          tsconfig.json
          rollup.config.js
          app/components/primer
          package.json
          yarn.lock
        )

        files.each { |f| dockerfile.copy(f, f) }

        # This directory needs to exist b/c some JavaScript thing copies the compiled
        # Primer CSS bundle into it.
        dockerfile.run("mkdir", "-p", "demo/app/assets/stylesheets")
        dockerfile.run("yarn", "install")
      end
    end

    kubernetes do
      add_plugin :rails_app do
        manage_database false

        root "demo/"
      end
    end
  end

  environment(:production) do
    instance_exec(&shared)

    kubernetes do
      provider :azure do
        subscription_id "550eb99d-d0c7-4651-a337-f53fa6520c4f"
        tenant_id "398a6654-997b-47e9-b12b-9515b896b4de"
        resource_group_name "primer"
        resource_name "primer"

        client_id "5ad1a188-b944-40eb-a2f8-cc683a6a65a0"
        client_secret ENV["AZURE_SPN_CLIENT_SECRET"]
      end

      configure_plugin :rails_app do
        hostname 'view-components-storybook.eastus.cloudapp.azure.com'
      end
    end
  end

  environment(:development) do
    instance_exec(&shared)

    kubernetes do
      configure_plugin :rails_app do
        tls_enabled false
        hostname 'localhost'
      end

      provider :kind
    end
  end
end
