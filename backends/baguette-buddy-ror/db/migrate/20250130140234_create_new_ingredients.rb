class CreateNewIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :ingredients do |t|
      t.references :receipe, null: false, foreign_key: true, type: :uuid
      t.references :product_item, null: false, foreign_key: true, type: :uuid
      t.integer :quantity, default: 1, null: false

      t.timestamps
    end
    add_index :ingredients, [:receipe_id, :product_item_id], unique: true
  end
end
