ActiveAdmin.register Course do
 
 active_admin_import :validate => false,
 :template => 'admin/course_import' ,
 headers_rewrites: { :'subjectarea_id' => :subjectarea_id, :'generaleducation_id' => :generaleducation_id, :'start_date' => :start_date, :'end_date' => :end_date, :'code' => :code},
 before_batch_import: ->(importer) {

                subject_names = importer.values_at(:subjectarea_id)
                 # replacing subject area name with subject area id
                 subjects   = SubjectArea.where(name: subject_names).pluck(:name, :id)
                 options = Hash[*subjects.flatten] # #{"Jane" => 2, "John" => 1}
                 importer.batch_replace(:subjectarea_id, options)
                 
                  ge_names = importer.values_at(:generaleducation_id)
                  # replacing general education name with general education id
                  geneds  = GeneralEducation.where(name: ge_names).pluck(:name, :id)
                  options = Hash[*geneds.flatten] # #{"Jane" => 2, "John" => 1}
                  importer.batch_replace(:generaleducation_id, options)
                 
                  wrong_s_dates = importer.values_at(:start_date)
                  options = wrong_s_dates.map {|wrong_dates|   {wrong_dates => Course.strptime(wrong_dates).to_s }.flatten } 
                  options.delete({"start_date"=>"start_date"})
                  options = Hash[*options.flatten]
                  importer.batch_replace(:'start_date', options)
                  
                  wrong_e_dates = importer.values_at(:end_date)
                  options = wrong_e_dates.map {|wrong_dates|   {wrong_dates => Course.strptime(wrong_dates).to_s }.flatten } 
                  options.delete({"start_date"=>"start_date"})
                  options = Hash[*options.flatten]
                  puts options
                  importer.batch_replace(:'end_date', options)
                  
       #       
       #    codes = importer.values_at(:code)
       #    options_codes = codes.map {|codes|   {codes => codes.split('-').first}.flatten } 
       #    options_sections = codes.map {|codes| {codes => codes.split('-').last}.flatten }
       #    options_codes = Hash[*options_codes.flatten]
       #    options_sections = Hash[*options_sections.flatten]
       #    importer.batch_replace(:'code', options_codes)
       #    importer.batch_replace(:'section', options_sections)
       #

                   
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
 :csv_headers => ["local_course_id", "subjectarea_id", "course_area", "prefix", "code", "section", "title",  "description", "prerequisites", "corequisites", "generaleducation_id", "level", "instructor", "credit", "start_date", "end_date", "books_url", "registration_url", "active", "course_method", "seats_available", "class_full"] 
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
