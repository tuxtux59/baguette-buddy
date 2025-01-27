class RenameIngredientToProductItem < ActiveRecord::Migration[7.1]
  def change
    rename_table :ingredients, :product_items
  end
end
