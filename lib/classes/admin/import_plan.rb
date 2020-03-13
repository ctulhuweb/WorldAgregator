require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

module RailsAdmin
  module Config
    module Actions
      class ImportPlan < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          subject = bindings[:object]
          subject.is_a? Tariff
        end

        register_instance_option :member do
          true
        end

        register_instance_option :link_icon do
          'icon-chevron-up'
        end

        register_instance_option :controller do
          -> { p @object.title }
        end
      end
    end
  end
end
