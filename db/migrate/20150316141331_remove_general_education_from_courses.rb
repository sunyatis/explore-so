class RemoveGeneralEducationFromCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :general_education
    add_column :courses, :generaleducation_id, :integer
  end
end
