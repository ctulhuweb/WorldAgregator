class AddStatusToOrders < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE order_status AS ENUM ('wait', 'cancel', 'success');
    SQL
    add_column :orders, :status, :order_status
  end

  def down
    remove_column :orders, :status
    execute <<-SQL
      DROP TYPE order_status;
    SQL
  end
end
