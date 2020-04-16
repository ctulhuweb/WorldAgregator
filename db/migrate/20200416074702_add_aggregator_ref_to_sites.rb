class AddAggregatorRefToSites < ActiveRecord::Migration[6.0]
  def change
    add_reference :sites, :aggregator, foreign_key: true
  end
end
