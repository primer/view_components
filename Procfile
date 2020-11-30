stories: cd demo; bundle install; bin/rails view_component_storybook:write_stories_json
rails: cd demo; bundle install; STORYBOOK=true bin/rails s -p 4000
storybook: cd demo; STORYBOOK=true bin/yarn storybook -p 5000
build: bundle exec rake docs:livereload
doctocat: cd docs; yarn install; yarn develop
