class AddDaSareasFilterToPrograms < ActiveRecord::Migration[6.0]
  def change
    add_column :programs, :das_area, :string
  end
end
