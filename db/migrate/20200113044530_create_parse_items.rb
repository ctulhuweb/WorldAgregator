class CreateParseItems < ActiveRecord::Migration[6.0]
  def change
    create_table :parse_items do |t|
      t.jsonb :data
      t.references :site, foreign_key: true
      t.timestamps
    end
  end
end
