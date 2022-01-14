stories: cd demo; bundle install; bin/rails view_component_storybook:write_stories_json --trace
rails: cd demo; bundle install; STORYBOOK=true bin/rails s -p 4000
storybook: cd demo; yarn install; STORYBOOK=true bin/yarn storybook -p 5000
build: yarn install; yarn run prepare; bundle exec rake docs:livereload
doctocat: cd docs; yarn install; yarn develop
