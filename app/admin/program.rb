ActiveAdmin.register Program do
   menu parent: 'Manage Programs', label: 'Programs'
  	active_admin_import :validate => true,
  	:template => 'admin/program_import' ,
     headers_rewrites: { :'subjectarea_id' => :subjectarea_id, :'levelabb_id' => :levelabb_id}, #:'school_id' => :school_id}, mass import
     before_batch_import: ->(importer) {
                    Program.where(sed: importer.values_at('sed')).delete_all

                    subject_names = importer.values_at(:subjectarea_id)
                     # replacing subject area name with subject area id
                     subjects   = SubjectArea.where(name: subject_names).pluck(:name, :id)
                     options = Hash[*subjects.flatten] # #{"Jane" => 2, "John" => 1}
                     importer.batch_replace(:subjectarea_id, options)

                      level_names = importer.values_at(:levelabb_id)
                      # replacing general education name with general education id
                      levels  = LevelAbb.where(name: level_names).pluck(:name, :id)
                      options = Hash[*levels.flatten] # #{"Jane" => 2, "John" => 1}
                      importer.batch_replace(:levelabb_id, options)
                      
                   #   school_names = importer.values_at(:school_id)
    #mass import   #   # replacing subject area name with subject area id
                   #   schools   = School.where(name: school_names).pluck(:name, :id)
                   #   options = Hash[*schools.flatten] # #{"Jane" => 2, "John" => 1}
                   #   importer.batch_replace(:school_id, options)

                       importer.csv_lines.map! { |row| row << importer.model.school_id}
                       importer.headers.merge!({:'school_id' => :school_id})

                   },
                   after_batch_import: ->(importer) {
                       Program.where(prog_title: "prog_title").delete_all
                    },
  :template_object => ActiveAdminImport::Model.new(
  :school_id => nil,
  #:hint => "file will be imported with such header format: 'body','title','author'",
  # mass import
  #:csv_headers => ["prog_title", "description", "summary", "subjectarea_id", "prog_level", "levelabb_id", "school_id", "duration", "delivery_method", "prerequisites", "program_url", "registration_url",  "open_suny", "per_courses_online", "synchronous", "synchronous_text", "tutoring", "tutoring_name", "tutoring_phone", "tutoring_email", "tutoring_url", "helpdesk", "helpdesk_phone", "helpdesk_email", "helpdesk_url", "concierge", "concierge_phone", "concierge_name", "concierge_email", "experiential_learning", "experiential_text", "plas", "plas_text", "accelerated", "accelerated_text", "level_expanded", "sed", "apply_now_url"] 
  :csv_headers => ["prog_title", "description", "summary", "subjectarea_id", "prog_level", "levelabb_id", "duration", "delivery_method", "prerequisites", "program_url", "registration_url",  "open_suny", "per_courses_online", "synchronous", "synchronous_text", "tutoring", "tutoring_name", "tutoring_phone", "tutoring_email", "tutoring_url", "helpdesk", "helpdesk_phone", "helpdesk_email", "helpdesk_url", "concierge", "concierge_phone", "concierge_name", "concierge_email", "experiential_learning", "experiential_text", "plas", "plas_text", "accelerated", "accelerated_text", "level_expanded", "sed", "apply_now_url"] 
  )
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :prog_title, :description, :summary, :subjectarea_id, :prog_level, :levelabb_id, :school_id, :duration, :delivery_method, :prerequisites, :program_url, :registration_url, :open_suny, :per_courses_online, :synchronous, :synchronous_text, :tutoring, :tutoring_name, :tutoring_phone, :tutoring_email, :tutoring_url, :helpdesk, :helpdesk_phone, :helpdesk_email, :helpdesk_url, :concierge, :concierge_phone, :concierge_name, :concierge_email, :experiential_learning, :experiential_text, :plas, :plas_text, :accelerated, :accelerated_text, :level_expanded, :sed, :apply_now_url, :cat_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  
  #filter :school_id, as: :select, :collection => School.pluck(:name, :id)

  form do |f|
  f.inputs "Program Details" do
  f.input :prog_title
  f.input :description
  f.input :subjectarea_id, as: :select, :collection => SubjectArea.pluck(:name, :id)
  f.input :prog_level,  :as => :select,  :collection => ["Undergraduate", "Graduate"]
  f.input :cat_id, as: :select, :collection => Category.pluck(:name, :id)
  f.input :levelabb_id
  f.input :school_id, as: :select, :collection => School.pluck(:name, :id)
  f.input :duration
  f.input :delivery_method
  f.input :prerequisites
  f.input :program_url
  f.input :registration_url
  f.input :open_suny, :as => :radio, :collection => [["Yes", true], ["No", false]]
  f.input :per_courses_online
  f.input :synchronous, :as => :radio, :collection => [["Yes", true], ["No", false]]
  f.input :synchronous_text
  f.input :tutoring, :as => :radio, :collection => [["Yes", true], ["No", false]]
  f.input :tutoring_name
  f.input :tutoring_phone
  f.input :tutoring_email
  f.input :tutoring_url
  f.input :helpdesk, :as => :radio, :collection => [["Yes", true], ["No", false]]
  f.input :helpdesk_phone
  f.input :helpdesk_email
  f.input :helpdesk_url
  f.input :concierge, :as => :radio, :collection => [["Yes", true], ["No", false]]
  f.input :concierge_phone
  f.input :concierge_name
  f.input :concierge_email
  f.input :experiential_learning, :as => :radio, :collection => [["Yes", true], ["No", false]]
  f.input :experiential_text
  f.input :plas, :as => :radio, :collection => [["Yes", true], ["No", false]]
  f.input :plas_text
  f.input :accelerated, :as => :radio, :collection => [["Yes", true], ["No", false]]
  f.input :accelerated_text
  f.input :summary
  f.input :level_expanded
  f.input :sed
  f.input :apply_now_url
  end
  f.actions
  end

  index do
     id_column
     column :sed
     column :prog_title
     column :school_id do |program|
       program.school.name
     end
     column :levelabb_id do |program|
       program.level_abb.name
     end
     column :level_expanded
    actions
  end


end
