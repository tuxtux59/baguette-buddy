class CreateReceipes < ActiveRecord::Migration[7.1]
  def change
    create_table :receipes do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :portions_number, default: 1, null: false
      t.binary :illustration

      t.timestamps
    end
    add_index :receipes, :title, unique: true
  end
end
