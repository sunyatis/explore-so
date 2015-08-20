class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :prog_title
      t.text :description
      t.integer :subjectarea_id
      t.string :prog_level
      t.integer :levelabb_id
      t.integer :school_id
      t.string :duration
      t.string :delivery_method
      t.text :prerequisites
      t.string :program_url
      t.string :registration_url
      t.string :open_suny
      t.string :per_courses_online
      t.boolean :synchronous
      t.string :synchronous_text
      t.boolean :tutoring
      t.string :tutoring_name
      t.string :tutoring_phone
      t.string :tutoring_email
      t.string :tutoring_url
      t.boolean :helpdesk
      t.string :helpdesk_phone
      t.string :helpdesk_email
      t.string :helpdesk_url
      t.boolean :concierge
      t.string :concierge_phone
      t.string :concierge_name
      t.string :concierge_email
      t.boolean :experiential_learning
      t.text :experiential_text
      t.boolean :plas
      t.text :plas_text
      t.boolean :accelerated
      t.text :accelerated_text
      t.text :summary
      t.string :level_expanded
      t.integer :sed
      t.string :apply_now_url
    end
  end
end
