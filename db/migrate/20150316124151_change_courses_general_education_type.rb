class ChangeCoursesGeneralEducationType < ActiveRecord::Migration
  def change
    change_column :courses, :generaleducation_id, :integer
  end
end
