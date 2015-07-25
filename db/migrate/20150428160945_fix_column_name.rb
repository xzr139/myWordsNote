class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :word_defs, :title, :title_id
    add_column :words, :note_id, :integer
  end
end
