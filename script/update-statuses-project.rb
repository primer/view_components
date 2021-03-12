#!/usr/bin/env ruby
#/ Usage: script/update-statuses-project
# frozen_string_literal: true

module Github
  GITHUB_ACCESS_TOKEN = ENV['GITHUB_TOKEN']
  URL = 'https://api.github.com/graphql'
  HttpAdapter = GraphQL::Client::HTTP.new(URL) do
    def headers(context)
      {
        "Authorization" => "Bearer #{GITHUB_ACCESS_TOKEN}",
        "User-Agent" => 'Ruby'
      }
    end
  end
  Schema = GraphQL::Client.load_schema(HttpAdapter)
  Client = GraphQL::Client.new(schema: Schema, execute: HttpAdapter)
end

class Project
  ProjectQuery = Github::Client.parse <<-'GRAPHQL'
    query {
      repository(owner: "primer", name: "view_components") {
        project(number: 3) {
          columns(first: 100) {
            nodes {
              name
              id
              databaseId
              cards {
                nodes {
                  id
                  databaseId
                  note
                }
              }
            }
          }
        }
      }
    }
  GRAPHQL

  def self.fetch_columns
    response = Github::Client.query(ProjectQuery)

    if response.errors.any?
      raise QueryExecutionError.new(response.errors[:data].join(", "))
    else
      response.data.repository.project.columns
    end
  end
end

# fetch project columns
# fetch cards

columns = Project.fetch_columns

puts columns

# TODO: find missing cards
# TODO: parse statuses.json
# TODO: move cards on wrong column
