class AddCampusAbbToSchool < ActiveRecord::Migration[6.0]
  def change
    add_column :schools, :abbv, :string
  end
end
