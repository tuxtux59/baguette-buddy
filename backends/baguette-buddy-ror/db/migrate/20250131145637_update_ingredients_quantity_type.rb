class UpdateIngredientsQuantityType < ActiveRecord::Migration[7.1]
  def change
    change_column :ingredients, :quantity, :decimal, scale: 2, precision: 6
  end
end
