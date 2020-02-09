class CreateParseFields < ActiveRecord::Migration[6.0]
  def change
    create_table :parse_fields do |t|
      t.string :name
      t.string :selector
      t.belongs_to(:site, foreign_key: true)
      t.timestamps
    end
  end
end
