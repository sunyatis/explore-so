class AddCoursesToPrograms < ActiveRecord::Migration[6.0]
  def change

      add_column :programs, :prog_courses, :string
      add_column :programs, :prog_cost_inst, :string
      add_column :programs, :prog_cost_outst, :string

  end
end
