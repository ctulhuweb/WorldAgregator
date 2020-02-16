class AddChosenToParseItem < ActiveRecord::Migration[6.0]
  def change
    add_column :parse_items, :chosen, :boolean, default: :false
  end
end
