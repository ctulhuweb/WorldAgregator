class AddActiveToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :active, :boolean, null: false, default: false
  end
end
