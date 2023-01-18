# frozen_string_literal: true

module Primer
  module Alpha
    MultiInput = Primer::FormComponents.from_input(Primer::Forms::Dsl::MultiInput)

    # Multi inputs are comprised of multiple constituent fields, only one of which is visible
    # at a given time. They are designed for situations where constituent inputs are shown or
    # hidden based on the value of another field. For example, consider an address form. If
    # the user chooses the USA as the country, the region input should show a list of states
    # and US territories; if the user instead chooses Canada, the region input should show a
    # list of Canadian provinces, etc.
    #
    # Unlike everywhere else in Primer forms, constituent inputs are not directly passed a
    # `name` attribute. Instead, developers pass a `name` attribute to the multi input itself.
    # The multi input then automatically assigns each constituent input the same name. This is
    # done so that the multi input looks like a single field from the server's point of view.
    # Using the address form example from earlier, this means only one value - either a US state
    # or a Canadian provice - will be submitted to the server under the `region` key.
    #
    # Actually, that's not quite true. Constituent inputs _are_ given a `name`, but it's added to
    # the input as the `data-name` attribute as a way to identify constituent inputs, and will not
    # be sent to the server.
    #
    # Note that this `MultiInput` component is designed for use outside Primer forms. For a multi
    # input suitable for use within a form, see the Primer forms documentation.
    class MultiInput < Primer::Component
      status :alpha

      # @!method initialize
      #
      # @example Default
      #   <%= render(Primer::Alpha::SelectList.new(name: :dietary_pref, label: "Dietary preference")) do |c| %>
      #     <% c.option(label: "Meatatarian", value: "meatatarian") %>
      #     <% c.option(label: "Vegetarian", value: "vegetarian") %>
      #   <% end %>
      #
      #   <%= render(Primer::Alpha::MultiInput.new(name: :dish, label: "Select dish")) do |c| %>
      #     <% c.select_list(name: :meatatarian) do |list| %>
      #       <% list.option(label: "Steak", value: "steak") %>
      #       <% list.option(label: "Salmon", value: "salmon") %>
      #     <% end %>
      #     <% c.select_list(name: :vegetarian, hidden: true) do |list| %>
      #       <% list.option(label: "Portobello mushroom", value: "portobello") %>
      #       <% list.option(label: "Tofu curry", value: "tofu") %>
      #     <% end %>
      #   <% end %>
      #
      #   <script type="text/javascript" data-eval="true">
      #     const dietaryPrefList = document.querySelector("[name=dietary_pref]");
      #     const dishMulti = document.querySelector("[data-name=dish]");
      #
      #     dietaryPrefList.onchange = (evt) => {
      #       switch (evt.target.value) {
      #         case 'meatatarian':
      #           dishMulti.activateField('meatatarian');
      #           break;
      #         case 'vegetarian':
      #           dishMulti.activateField('vegetarian');
      #           break;
      #       }
      #     };
      #   </script>
      #
      # @macro form_input_attributes
      # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    end
  end
end
