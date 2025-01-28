class AddSlugToReceipe < ActiveRecord::Migration[7.1]
  def change
    add_column :receipes, :slug, :string
    add_index :receipes, :slug, unique: true

    execute <<-SQL
      UPDATE receipes SET slug = regexp_replace(lower(title), '[^a-z0-9]+', '_', 'g')
    SQL
  end
end
