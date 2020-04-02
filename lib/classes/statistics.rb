require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

class Statistics < RailsAdmin::Config::Actions::Base
  register_instance_option :root? do
    true
  end
end