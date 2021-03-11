class AddNewSubjectArea < ActiveRecord::Migration[6.0]
  def change
      add_column :programs, :subject_area, :string
  end
end
