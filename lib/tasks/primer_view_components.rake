# frozen_string_literal: true

require "rubocop"
require "better_html"
require "better_html/parser"
require "erb_lint/processed_source"
require_relative "helpers/ast_processor"

ERB_GLOB = "**/*.html{+*,}.erb"
RB_GLOB = "**/*.rb"
# copied from Rails: action_view/template/handlers/erb/erubi.rb
BLOCK_EXPR = /\s*((\s+|\))do|\{)(\s*\|[^|]*\|)?\s*\Z/.freeze

namespace :primer_view_components do
  desc "Report arguments used in each component"
  task :report, [:paths] do |t, args|
    paths = args[:paths].split
    stats = {}

    rb_files = paths.reduce([]) { |mem, path| mem + Dir[File.join(path, RB_GLOB)] }

    rb_files.each do |f|
      ast = RuboCop::AST::ProcessedSource.from_file(f, RUBY_VERSION.to_f).ast
      AstProcessor.process_ast(ast, stats)
    end

    erb_files = paths.reduce([]) { |mem, path| mem + Dir[File.join(path, ERB_GLOB)] }

    erb_files.each do |f|
      erb_ast = ERBLint::ProcessedSource.new(f, File.read(f)).ast

      erb_ast.descendants(:erb).each do |erb_node|
        indicator, _, code_node, = *erb_node

        next if indicator&.children&.first == "#" # don't analyze comments

        trimmed_source = code_node.loc.source.sub(BLOCK_EXPR, "").strip
        ast = RuboCop::AST::ProcessedSource.new(trimmed_source, RUBY_VERSION.to_f).ast
        AstProcessor.process_ast(ast, stats)
      end
    end

    File.open(".primer-view-components-report.json", "w") do |f|
      f.write(JSON.pretty_generate(stats))
      f.write($INPUT_RECORD_SEPARATOR)
    end
  end
end
