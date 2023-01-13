---
title: "Getting started"
---

Primer contains a framework for declaratively building forms. It was designed to meet the following goals:

1. Be accessible by default.
1. Integrate deeply with Ruby on Rails and its existing form capabilities.
1. Follow web standards.
1. Adhere to Primer's [form interface guidelines](/design/ui-patterns/forms).

<br>To that end, customization options are intentionally limited.

### Example for the Impatient

A number of the concepts present in Primer Forms are borrowed from the [view_component](https://viewcomponent.org) framework. For example, forms are defined inside Ruby classes and rendered in very similar fashion. Let's create a sign up form and render it on the page.

First we define the form:

```ruby
class SignUpForm < ApplicationForm
  form do |sign_up_form|
    sign_up_form.group(layout: :horizontal) do |name_group|
      name_group.text_field(
        name: :first_name,
        label: "First name",
        required: true,
        caption: "What your friends call you."
      )

      name_group.text_field(
        name: :last_name,
        label: "Last name",
        required: true,
        caption: "What the principal calls you."
      )
    end

    sign_up_form.text_field(
      name: :dietary_restrictions,
      label: "Dietary restrictions",
      caption: "Any allergies?"
    )

    if @show_notifications_checkbox
      sign_up_form.check_box(
        name: :email_notifications,
        label: "Send me gobs of email!",
        caption: "Check this if you enjoy getting spam."
      )
    end

    sign_up_form.submit(label: "Submit")
  end

  def initialize(show_notifications_checkbox: true)
    @show_notifications_checkbox = show_notifications_checkbox
  end
end
```

Now the form can be rendered using the familiar Rails `render` method:

```ruby
<%= form_with(model: @user) do |f| %>
  <%= render SignUpForm.new(f, show_notifications_checkbox: false) %>
<% end %>
```
