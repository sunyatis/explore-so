ActiveAdmin.register Course do
 
 active_admin_import :validate => false,
 :template => 'admin/course_import' ,
 headers_rewrites: { :'subjectarea_id' => :subjectarea_id, :'generaleducation_id' => :generaleducation_id, :'start_date' => :start_date},
 before_batch_import: ->(importer) {

                subject_names = importer.values_at(:subjectarea_id)
                 puts subject_names
                 # replacing subject area name with subject area id
                 subjects   = SubjectArea.where(name: subject_names).pluck(:name, :id)
                 options = Hash[*subjects.flatten] # #{"Jane" => 2, "John" => 1}
                 importer.batch_replace(:subjectarea_id, options)
                 
                  ge_names = importer.values_at(:generaleducation_id)
                  puts ge_names
                  # replacing general education name with general education id
                  geneds  = GeneralEducation.where(name: ge_names).pluck(:name, :id)
                  options = Hash[*geneds.flatten] # #{"Jane" => 2, "John" => 1}
                  importer.batch_replace(:generaleducation_id, options)
                  
                 # start_dates = importer.values_at(:start_date)
                  
                  #start_date = Hash[*start_dates.flatten]
                  #date = "#{start_date['start_date']}"
                  #date = Course.strptime(date).to_s
                  #date = {"start_date" => "#{date}"}
                  #date = Hash[*date.flatten]
                  #date = Course.strptime(start_dates).to_s

                  #importer.csv_lines.map! { |row| row << date}
                  #importer.headers.merge!({:'start_date' => :start_date})

                  #puts date
                  
                  #importer.batch_replace(:start_date, date)
                 
                  
                  importer.csv_lines.map! { |row| row << importer.model.catalog_id}
                  importer.headers.merge!({:'catalog_id' => :catalog_id}) 
                  
                  importer.csv_lines.map! { |row| row << importer.model.school_id}
                  importer.headers.merge!({:'school_id' => :school_id})
               },
               after_batch_import: ->(importer) {
                  Course.where(title: "title").delete_all
               },
 :template_object => ActiveAdminImport::Model.new(
 :catalog_id => nil,
 :school_id => nil,
 #:hint => "file will be imported with such header format: 'body','title','author'",
 :csv_headers => ["title", "code", "description", "credit", "start_date", "end_date", "local_course_id", "prefix", "section", "prerequisites", "corequisites", "books_url", "registration_url", "active", "level", "subjectarea_id", "course_area", "generaleducation_id", "instructor", "course_method", "seats_available", "class_full"] 
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
