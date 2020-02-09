class AddStatusToParseItems < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE parse_item_status AS ENUM ('new', 'viwed', 'deleted');
    SQL
    add_column :parse_items, :status, :parse_item_status
  end

  def down
    remove_column :parse_items, :status
    execute <<-SQL
      DROP TYPE parse_item_status;
    SQL
  end
end
