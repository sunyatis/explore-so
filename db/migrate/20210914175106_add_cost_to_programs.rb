class AddCostToPrograms < ActiveRecord::Migration[6.0]
  def change
    add_column :programs, :prog_appt_link, :string
  end
end
