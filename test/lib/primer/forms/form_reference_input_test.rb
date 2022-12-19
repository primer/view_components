# frozen_string_literal: true

require "lib/test_helper"

class Primer::Forms::FormReferenceInputTest < Minitest::Test
  include Primer::ComponentTestHelpers

  class UserForm < ApplicationForm
    form do |user_form|
      user_form.text_field(name: :first_name, label: "First name")
      user_form.text_field(name: :last_name, label: "Last name")
      user_form.fields_for(:address, nested: @nested) do |builder|
        AddressForm.new(builder)
      end
    end

    def initialize(nested:)
      @nested = nested
    end
  end

  class AddressForm < ApplicationForm
    form do |address_form|
      address_form.text_field(name: :street, label: "Street")
      address_form.text_field(name: :city, label: "City")
      address_form.text_field(name: :state, label: "State")
    end
  end

  def test_nests_fields
    render_in_view_context do
      primer_form_with(scope: :user, url: "/foo") do |f|
        render(UserForm.new(f, nested: true))
      end
    end

    assert_selector "input[name='user[address][street]']"
    assert_selector "input[name='user[address][city]']"
    assert_selector "input[name='user[address][state]']"
  end

  def test_does_not_nest_fields
    render_in_view_context do
      primer_form_with(scope: :user, url: "/foo") do |f|
        render(UserForm.new(f, nested: false))
      end
    end

    assert_selector "input[name='address[street]']"
    assert_selector "input[name='address[city]']"
    assert_selector "input[name='address[state]']"
  end
end
