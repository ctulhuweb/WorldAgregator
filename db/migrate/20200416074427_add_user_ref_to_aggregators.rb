class AddUserRefToAggregators < ActiveRecord::Migration[6.0]
  def change
    add_reference :aggregators, :user, null: false, foreign_key: true
  end
end
