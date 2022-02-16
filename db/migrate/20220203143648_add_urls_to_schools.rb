class AddUrlsToSchools < ActiveRecord::Migration[6.0]
  def change
    add_column :schools, :course_registration_url, :string
    add_column :schools, :bookstore_url, :string
  end
end
