class RemoveUnusedFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :programs, :prerequisites
    remove_column :programs, :program_url
    remove_column :programs, :registration_url
    remove_column :programs, :per_courses_online
    remove_column :programs, :synchronous_text
    remove_column :programs, :tutoring_name
    remove_column :programs, :tutoring_phone
    remove_column :programs, :tutoring_email
    remove_column :programs, :tutoring_url
    remove_column :programs, :helpdesk
    remove_column :programs, :helpdesk_phone
    remove_column :programs, :helpdesk_email
    remove_column :programs, :helpdesk_url
    remove_column :programs, :concierge_phone
    remove_column :programs, :concierge_name
    remove_column :programs, :concierge_email
    remove_column :programs, :experiential_text
    remove_column :programs, :plas_text
    remove_column :programs, :accelerated_text
    remove_column :programs, :summary
    remove_column :programs, :levelabb_id    
  end
end
