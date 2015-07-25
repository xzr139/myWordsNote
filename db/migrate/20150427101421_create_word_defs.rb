class CreateWordDefs < ActiveRecord::Migration
  def change
    create_table :word_defs do |t|
      t.string :title
      t.text :en
      t.text :jp
      t.text :eg

      t.timestamps null: false
    end
  end
end
