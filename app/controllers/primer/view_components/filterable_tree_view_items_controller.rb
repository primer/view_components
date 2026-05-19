# frozen_string_literal: true

module Primer
  module ViewComponents
    # :nodoc:
    # :nocov:
    class FilterableTreeViewItemsController < ApplicationController
      # A node in the demo tree. Leaf nodes have no children.
      TreeNode = Data.define(:id, :label, :children, :all_descendant_ids) do
        def leaf?
          children.nil? || children.empty?
        end

        # Returns a filtered copy of this node. Leaf nodes are included if they match the query.
        # Sub-tree nodes are included if they match OR any descendant matches. The all_descendant_ids
        # field always reflects the ORIGINAL (unfiltered) descendant set, so clients can use it to
        # determine which nodes to select when "include sub-items" is active on a filtered tree.
        def filter(query)
          return self if query.empty?

          if leaf?
            matches?(query) ? self : nil
          else
            filtered_children = children.filter_map { |child| child.filter(query) }
            if matches?(query) || !filtered_children.empty?
              self.class.new(
                id: id,
                label: label,
                children: filtered_children,
                all_descendant_ids: all_descendant_ids
              )
            end
          end
        end

        private

        def matches?(query)
          label.downcase.include?(query.downcase)
        end
      end

      # Build a leaf node
      def self.leaf(id:, label:)
        TreeNode.new(id: id, label: label, children: [], all_descendant_ids: [])
      end

      # Build a branch node, computing all_descendant_ids automatically
      def self.branch(id:, label:, children:)
        all_ids = children.flat_map { |c| [c.id] + c.all_descendant_ids }
        TreeNode.new(id: id, label: label, children: children, all_descendant_ids: all_ids)
      end

      TREE = [
        branch(
          id: "hogwarts",
          label: "Hogwarts School of Witchcraft and Wizardry",
          children: [
            branch(
              id: "hogwarts-students",
              label: "Students",
              children: [
                branch(
                  id: "gryffindor",
                  label: "Gryffindor",
                  children: [
                    leaf(id: "harry-potter",       label: "Harry Potter"),
                    leaf(id: "ron-weasley",         label: "Ron Weasley"),
                    leaf(id: "hermione-granger",    label: "Hermione Granger"),
                    leaf(id: "neville-longbottom",  label: "Neville Longbottom"),
                    leaf(id: "ginny-weasley",       label: "Ginny Weasley")
                  ]
                ),
                branch(
                  id: "slytherin",
                  label: "Slytherin",
                  children: [
                    leaf(id: "draco-malfoy",    label: "Draco Malfoy"),
                    leaf(id: "pansy-parkinson", label: "Pansy Parkinson"),
                    leaf(id: "blaise-zabini",   label: "Blaise Zabini")
                  ]
                ),
                branch(
                  id: "ravenclaw",
                  label: "Ravenclaw",
                  children: [
                    leaf(id: "luna-lovegood", label: "Luna Lovegood"),
                    leaf(id: "cho-chang",     label: "Cho Chang"),
                    leaf(id: "terry-boot",    label: "Terry Boot")
                  ]
                ),
                branch(
                  id: "hufflepuff",
                  label: "Hufflepuff",
                  children: [
                    leaf(id: "cedric-diggory", label: "Cedric Diggory"),
                    leaf(id: "susan-bones",    label: "Susan Bones"),
                    leaf(id: "hannah-abbott",  label: "Hannah Abbott")
                  ]
                )
              ]
            ),
            branch(
              id: "hogwarts-teachers",
              label: "Teachers",
              children: [
                leaf(id: "albus-dumbledore",  label: "Albus Dumbledore"),
                leaf(id: "minerva-mcgonagall", label: "Minerva McGonagall"),
                leaf(id: "severus-snape",     label: "Severus Snape"),
                leaf(id: "rubeus-hagrid",     label: "Rubeus Hagrid"),
                leaf(id: "remus-lupin",       label: "Remus Lupin"),
                leaf(id: "sybill-trelawney",  label: "Sybill Trelawney")
              ]
            )
          ]
        ),
        branch(
          id: "beauxbatons",
          label: "Beauxbatons Academy of Magic",
          children: [
            branch(
              id: "beauxbatons-students",
              label: "Students",
              children: [
                leaf(id: "fleur-delacour",    label: "Fleur Delacour"),
                leaf(id: "gabrielle-delacour", label: "Gabrielle Delacour"),
                leaf(id: "cecile-fontaine",   label: "Cécile Fontaine")
              ]
            ),
            branch(
              id: "beauxbatons-teachers",
              label: "Teachers",
              children: [
                leaf(id: "olympe-maxime",   label: "Olympe Maxime"),
                leaf(id: "sylvie-beaumont", label: "Sylvie Beaumont")
              ]
            )
          ]
        ),
        branch(
          id: "durmstrang",
          label: "Durmstrang Institute",
          children: [
            branch(
              id: "durmstrang-students",
              label: "Students",
              children: [
                leaf(id: "viktor-krum",      label: "Viktor Krum"),
                leaf(id: "dmitri-poliakoff", label: "Dmitri Poliakoff"),
                leaf(id: "gregor-tarasov",   label: "Gregor Tarasov")
              ]
            ),
            branch(
              id: "durmstrang-teachers",
              label: "Teachers",
              children: [
                leaf(id: "igor-karkaroff", label: "Igor Karkaroff"),
                leaf(id: "fyodor-dolohov", label: "Fyodor Dolohov")
              ]
            )
          ]
        )
      ].freeze

      def index
        query = params[:query].to_s.strip
        select_variant = (params[:select_variant].presence || "multiple").to_sym
        nodes = TREE.filter_map { |node| node.filter(query) }

        render locals: {
          nodes: nodes,
          query: query,
          select_variant: select_variant
        }
      end

      def async_form_tree
        query = params[:query].to_s.strip
        name = params[:name].to_s.presence || "characters"
        nodes = TREE.filter_map { |node| node.filter(query) }
        builder = ActionView::Helpers::FormBuilder.new("", nil, view_context, {})

        render locals: {
          nodes: nodes,
          query: query,
          name: name,
          builder: builder
        }
      end
    end
  end
end
