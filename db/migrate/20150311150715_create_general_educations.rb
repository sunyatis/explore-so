class CreateGeneralEducations < ActiveRecord::Migration
  def change
    create_table :general_educations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
