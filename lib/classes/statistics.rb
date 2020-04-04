require 'rails_admin/config/actions'
require 'rails_admin/config/actions/base'

class Statistics < RailsAdmin::Config::Actions::Base
  register_instance_option :root? do
    true
  end

  register_instance_option :controller do
    Proc.new do
      @active_users = User.joins(:orders).where(orders: {status: 'active'}).count
      @active_orders = Order.status_active.joins(:tariff).group('tariffs.title').count(:id)
      @popular_sites_url = Site.group(:url).having("count(id) > 0").order("count(id) desc").count(:id)
      query = "SELECT date_trunc('month', created_at) AS parse_month, count(id) FROM parse_items GROUP BY parse_month"
      @parse_items_monthly = ApplicationRecord.connection.execute(query)
    end
  end
    
end