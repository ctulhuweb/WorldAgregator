class CreateAggregators < ActiveRecord::Migration[6.0]
  def change
    create_table :aggregators do |t|
      t.string :title
      t.boolean :active

      t.timestamps
    end
  end
end
