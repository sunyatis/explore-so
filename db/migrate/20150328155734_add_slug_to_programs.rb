class AddSlugToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :slug, :string
    add_index :programs, :slug, unique: true
  end
end
