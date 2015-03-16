class ChangeCoursesGeneralEducation < ActiveRecord::Migration
  def change
    rename_column :courses, :general_education, :generaleducation_id
  end
end
