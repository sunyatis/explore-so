class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :school_url
      t.string :registration_url
      t.string :tuition_url
      t.string :financial_aid_url

      t.timestamps null: false
    end
  end
end
