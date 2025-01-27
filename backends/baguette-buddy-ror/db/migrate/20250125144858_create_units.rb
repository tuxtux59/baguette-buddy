class CreateUnits < ActiveRecord::Migration[7.1]
  def change
    create_table :units do |t|
      t.string :name
      t.string :plural
      t.string :abbreviation
      t.string :variants, array: true , default: []

      t.timestamps
    end
    add_index :units, :name, unique: true
    add_index :units, :abbreviation, unique: true
  end
end
