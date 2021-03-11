class AddNewSubjectAreaFields < ActiveRecord::Migration[6.0]
  def change
      add_column :programs, :subject_area_2, :string
      add_column :programs, :subject_area_3, :string
  end
end