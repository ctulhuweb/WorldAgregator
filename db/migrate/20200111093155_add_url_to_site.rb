class AddUrlToSite < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :url, :string, default: ""
  end
end
