ActiveAdmin.register Course do
 menu parent: 'Manage Courses', label: 'Courses'
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
  # mass import
#:csv_headers => ["catalog_id", "local_course_id", "subjectarea_id", "school_id", "course_area", "prefix", "code", "section", "title",  "description", "prerequisites", "corequisites", "generaleducation_id", "level", "instructor", "credit", "start_date", "end_date", "books_url", "registration_url", "active", "course_method", "seats_available", "class_full"] 
 )


  
  filter :catalog_id, as: :select, :collection => Catalog.pluck(:name, :id)
  filter :school_id, as: :select, :collection => School.pluck(:name, :id)
  filter :subjectarea_id, as: :select, :collection => SubjectArea.pluck(:name, :id)
  filter :generaleducation_id, as: :select, :collection => GeneralEducation.pluck(:name, :id)
  filter :cat_id, as: :select, :collection => Category.pluck(:name, :id)
  filter :title
  filter :code
  filter :description
  filter :start_date
  filter :end_fate
  filter :local_course_id
  filter :prefix
  filter :section
  filter :prerequisites
  filter :corequisites
  filter :books_url
  filter :registration_url
  filter :active
  filter :level
  filter :course_area
  filter :instructor
  filter :course_method
  filter :seats_available
  filter :class_full
  
  index do
    id_column
    column :catalog_id
     column :school_id
     column :subjectarea_id
     column :generaleducation_id
     column :cat_id
     column :title
     column :code
     column :start_date
     column :end_fate
     column :local_course_id
     column :prefix
     column :section
     column :active
     column :level
     column :course_area
     column :instructor
     column :course_method
     column :seats_available
     column :class_full
    actions
  end
   
  



  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :catalog_id, :title, :code, :description, :credit, :start_date, :end_date, :local_course_id, :prefix, :section, :prerequisites, :corequisites, :books_url, :registration_url, :active, :level, :school_id, :subjectarea_id, :course_area, :generaleducation_id, :instructor, :course_method, :seats_available, :class_full, :cat_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
