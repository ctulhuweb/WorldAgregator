class UpdateOrderStatusType < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!
  def up
    execute <<-SQL
      ALTER TYPE order_status ADD VALUE 'active'
    SQL
  end

  def down
    execute <<-SQL
      DROP TYPE order_status;
      CREATE TYPE order_status AS ENUM ('wait', 'cancel', 'success');
    SQL
  end
end
