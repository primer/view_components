#!/usr/bin/env ruby
#/ Usage: script/update-statuses-project
# frozen_string_literal: true

require "graphql/client"
require "graphql/client/http"

statuses = File.read(File.join(File.dirname(__FILE__), "../static/statuses.json"))
statuses_json = JSON.parse(statuses)

class QueryExecutionError < StandardError; end

module Github
  GITHUB_ACCESS_TOKEN = ENV.fetch("GITHUB_TOKEN")
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
                  column {
                    name
                  }
                }
              }
            }
          }
        }
      }
    }
  GRAPHQL

  CreateCard = Github::Client.parse <<-'GRAPHQL'
    mutation($note: String!, $projectColumnId: ID!) {
      addProjectCard(input:{note: $note, projectColumnId: $projectColumnId, clientMutationId: "pvc-actions"}) {
        __typename
      }
    }
  GRAPHQL

  MoveCard = Github::Client.parse <<-'GRAPHQL'
    mutation($cardId: ID!, $columnId: ID!) {
      moveProjectCard(input:{cardId: $cardId, columnId: $columnId, clientMutationId: "pvc-actions"}) {
        __typename
      }
    }
  GRAPHQL

  def self.create_card(note:, column_id:)
    response = Github::Client.query(CreateCard, variables: { note: note, project_column_id: column_id })

    if response.errors.any?
      raise QueryExecutionError.new(response.errors[:data].join(", "))
    end
  end

  def self.move_card(card_id:, column_id:)
    response = Github::Client.query(MoveCard, variables: { card_id: card_id, column_id: column_id })

    if response.errors.any?
      raise QueryExecutionError.new(response.errors[:data].join(", "))
    end
  end

  def self.fetch_columns
    response = Github::Client.query(ProjectQuery)

    if response.errors.any?
      raise QueryExecutionError.new(response.errors[:data].join(", "))
    else
      response.data.repository.project.columns
    end
  end
end

columns = Project.fetch_columns.nodes

@column_mapping = {}
columns.each do |column|
  @column_mapping[column.name.downcase] = column.id
end

@cards = columns.map(&:cards).map(&:nodes).flatten

def get_card(name_prefix:)
  @cards.find { |card| card.note.start_with?(name_prefix) }
end

def on_correct_column(card_id:, status:)
  card = @cards.find { |card| card.id == card_id }

  card.column.name.downcase == status.downcase
end

def move_card(card_id:, status:)
  column_id = @column_mapping[status.downcase]

  puts "move card with #{card_id} to #{status} on column #{column_id}"

  Project.move_card(card_id: card_id, column_id: column_id)
end

def create_card(component_name:, status:)
  puts "create card with #{component_name} on #{status}"

  column_id = @column_mapping[status.downcase]

  Project.create_card(note: component_name, column_id: column_id)
end

statuses_json.each do |component_name, component_status|
  card = get_card(name_prefix: component_name)

  if card
    if !on_correct_column(card_id: card.id, status: component_status)
      move_card(card_id: card.id, status: component_status)
    else
      puts "#{card.id} is on the right column. noop"
    end
  else
    create_card(component_name: component_name, status: component_status)
  end
end
