class AddCatIdToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :cat_id, :integer
  end
end
