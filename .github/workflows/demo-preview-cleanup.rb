# frozen_string_literal: true

require "json"

puts "Querying for open pull requests..."
open_pr_ids = JSON.parse(`gh pr list --repo primer/view_components --state open --json number`)
open_pr_ids.map! { |data| data["number"] }
puts "Found #{open_pr_ids.size} open pull requests"

puts "Querying for existing preview environments..."
preview_envs = JSON.parse(`az container list -g primer`)
preview_env_ids =
  preview_envs
    .select { |data| data["name"].start_with?("primer-view-components-preview-") }
    .map { |data| data["name"].split("-").last.to_i }
puts "Found #{preview_env_ids.size} existing preview environments"

preview_env_ids_to_delete = preview_env_ids - open_pr_ids
puts "Identified #{preview_env_ids_to_delete.size} preview environments to delete:"
puts preview_env_ids_to_delete.map { |pr_id| "- primer-view-components-preview-#{pr_id}" }.join("\n")

preview_env_ids_to_delete.each_with_index do |pr_id, index|
  puts "Deleting preview environment #{index + 1}/#{preview_env_ids_to_delete.size}"
  system "az container delete -n 'primer-view-components-preview-#{pr_id}' -g primer -y &> File::NULL"
end

puts "Deleted #{preview_env_ids_to_delete.size} preview environments"
