class AddMainSelectorToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :main_selector, :string
  end
end
