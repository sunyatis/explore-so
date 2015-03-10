ActiveAdmin.register Course do
 active_admin_import :validate => true,
 :template_object => ActiveAdminImport::Model.new(
 #:hint => "file will be imported with such header format: 'body','title','author'",
 :csv_headers => ["catalog_id", "title", "code", "description", "credit", "start_date", "end_date", "local_course_id", "prefix", "section", "prerequisites", "corequisites", "books_url", "registration_url", "active", "level", "school_id", "subjectarea_id", "course_area", "general_education", "instructor", "course_method", "seats_available", "class_full"] 
 )

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :catalog_id, :title, :code, :description, :credit, :start_date, :end_date, :local_course_id, :prefix, :section, :prerequisites, :corequisites, :books_url, :registration_url, :active, :level, :school_id, :subjectarea_id, :course_area, :general_education, :instructor, :course_method, :seats_available, :class_full
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
