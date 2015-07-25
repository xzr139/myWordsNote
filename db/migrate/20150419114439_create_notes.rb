class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :name
      t.text :comment
      t.integer :mark

      t.timestamps null: false
    end
  end
end
