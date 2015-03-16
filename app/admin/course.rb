ActiveAdmin.register Course do
 active_admin_import :validate => true,
 :template => 'admin/import' ,
 headers_rewrites: { :'subjectarea_id' => :subjectarea_id, :'generaleducation_id' => :generaleducation_id,},
 before_batch_import: ->(importer) {
                subject_names = importer.values_at(:subjectarea_id)
                 # replacing author name with author id
                 subjects   = SubjectArea.where(name: subject_names).pluck(:name, :id)
                 options = Hash[*subjects.flatten] # #{"Jane" => 2, "John" => 1}
                 puts options
                 importer.batch_replace(:subjectarea_id, options)
                 
                  ge_names = importer.values_at(:generaleducation_id)
                  # replacing author name with author id
                  geneds  = GeneralEducation.where(name: ge_names).pluck(:name, :id)
                  options = Hash[*geneds.flatten] # #{"Jane" => 2, "John" => 1}
                  puts options
                  importer.batch_replace(:generaleducation_id, options)
               },
 :template_object => ActiveAdminImport::Model.new(
 #:hint => "file will be imported with such header format: 'body','title','author'",
 :csv_headers => ["catalog_id", "title", "code", "description", "credit", "start_date", "end_date", "local_course_id", "prefix", "section", "prerequisites", "corequisites", "books_url", "registration_url", "active", "level", "school_id", "subjectarea_id", "course_area", "generaleducation_id", "instructor", "course_method", "seats_available", "class_full"] 
 )

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :catalog_id, :title, :code, :description, :credit, :start_date, :end_date, :local_course_id, :prefix, :section, :prerequisites, :corequisites, :books_url, :registration_url, :active, :level, :school_id, :subjectarea_id, :course_area, :generaleducation_id, :instructor, :course_method, :seats_available, :class_full
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
