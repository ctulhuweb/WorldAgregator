class DeleteForeignKey < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :parse_fields, :sites
  end
end
