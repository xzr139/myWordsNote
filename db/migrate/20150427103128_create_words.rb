class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :title
      t.string :pos
      t.string :pron
      t.string :ipa

      t.timestamps null: false
    end
  end
end
