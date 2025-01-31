class AddCookingTimeToReceipes < ActiveRecord::Migration[7.1]
  def change
    add_column :receipes, :cooking_time, :integer, default: 1
  end
end
