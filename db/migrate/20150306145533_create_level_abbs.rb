class CreateLevelAbbs < ActiveRecord::Migration
  def change
    create_table :level_abbs do |t|
        t.string :name
        t.string :description
    end
  end
end
