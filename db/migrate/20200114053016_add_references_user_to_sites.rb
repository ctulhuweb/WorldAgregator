class AddReferencesUserToSites < ActiveRecord::Migration[6.0]
  def change
    add_reference :sites, :user
  end
end
