class UpdateModelsIdTypeToUuid < ActiveRecord::Migration[7.1]
  def up
    remove_reference :receipes, :user, foreign_key: true
    remove_reference :ingredients, :unit, foreign_key: true

    %i[users units ingredients receipes].each do |table_name|
      add_column table_name, :uuid, :uuid, default: "gen_random_uuid()", null: false
  
      change_table table_name do |t|
        t.remove :id
        t.rename :uuid,  :id
      end
      execute "ALTER TABLE #{table_name.to_s} ADD PRIMARY KEY (id);"
    end

    add_reference :receipes, :user, type: :uuid, foreign_key: true
    add_reference :ingredients, :unit, type: :uuid, foreign_key: true
  end

  def down
    remove_reference :receipes, :user, foreign_key: true  if foreign_key_exists?(:receipes, :user)
    remove_reference :ingredients, :unit, foreign_key: true if foreign_key_exists?(:ingredients, :unit)
    

    %i[users units ingredients receipes].each do |table_name|
      change_column table_name, :id, :string
    end

    add_reference :receipes, :user, type: :string, foreign_key: true
    add_reference :ingredients, :unit, type:  :string, foreign_key: true
  end
end
