stories: cd demo; bin/rails view_component_storybook:write_stories_json
rails: cd demo; STORYBOOK=true bin/rails s -p 4000
storybook: cd demo; STORYBOOK=true bin/yarn storybook -p 5000
build: bundle exec rake docs:livereload
doctocat: cd docs; yarn develop
