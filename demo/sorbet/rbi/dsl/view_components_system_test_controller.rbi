# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `ViewComponentsSystemTestController`.
# Please instead update this file by running `bin/tapioca dsl ViewComponentsSystemTestController`.


class ViewComponentsSystemTestController
  include GeneratedUrlHelpersModule
  include GeneratedPathHelpersModule

  sig { returns(HelperProxy) }
  def helpers; end

  module HelperMethods
    include ::Primer::FormHelper
    include ::ViteRails::TagHelpers
    include ::ActionController::Base::HelperMethods
    include ::ApplicationHelper
    include ::PreviewHelper
  end

  class HelperProxy < ::ActionView::Base
    include HelperMethods
  end
end
