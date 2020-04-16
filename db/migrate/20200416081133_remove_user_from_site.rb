class RemoveUserFromSite < ActiveRecord::Migration[6.0]
  def change
    remove_reference :sites, :user, null: false
  end
end
