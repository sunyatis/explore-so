class AddCatIdToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :cat_id, :integer
  end
end
