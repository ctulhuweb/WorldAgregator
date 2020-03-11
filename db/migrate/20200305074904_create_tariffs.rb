class CreateTariffs < ActiveRecord::Migration[6.0]
  def change
    create_table :tariffs do |t|
      t.string :title
      t.integer :count_sites
      t.integer :parse_interval

      t.timestamps
    end
  end
end
