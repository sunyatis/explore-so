class AddCampusTypeToSchools < ActiveRecord::Migration[6.0]
  def change
     add_column :schools, :campus_type, :string
  end
end
