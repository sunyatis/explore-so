class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :catalog_id
      t.string :title
      t.string :code
      t.text :description
      t.integer :credit
      t.date :start_date
      t.date :end_date
      t.string :local_course_id
      t.string :prefix
      t.string :section
      t.text :prerequisites
      t.text :corequisites
      t.string :books_url
      t.string :registration_url
      t.boolean :active
      t.string :level
      t.integer :school_id
      t.integer :subjectarea_id
      t.string :course_area
      t.string :general_education
      t.string :instructor
      t.string :course_method
      t.integer :seats_available
      t.boolean :class_full

      t.timestamps null: false
    end
  end
end
