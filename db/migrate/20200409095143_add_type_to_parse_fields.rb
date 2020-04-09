class AddTypeToParseFields < ActiveRecord::Migration[6.0]
  def change
    add_column :parse_fields, :field_type, :string, default: "custom"
    add_index :parse_fields, :field_type 
  end
end
