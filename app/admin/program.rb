ActiveAdmin.register Program do
   menu parent: 'Manage Programs', label: 'Programs'
  	active_admin_import :validate => true,
  	:template => 'admin/program_import' ,
     headers_rewrites: { :'subjectarea_id' => :subjectarea_id}, #, :'school_id' => :school_id}, #mass import
     before_batch_import: ->(importer) {
                    #Program.where(sed: importer.values_at('sed')).delete_all

                    subject_names = importer.values_at(:subjectarea_id)
                     # replacing subject area name with subject area id
                     subjects   = SubjectArea.where(name: subject_names).pluck(:name, :id)
                     options = Hash[*subjects.flatten] # #{"Jane" => 2, "John" => 1}
                     importer.batch_replace(:subjectarea_id, options)
                      
                 #  school_names = importer.values_at(:school_id)
    #mass import #  # replacing subject area name with subject area id
                 #  schools   = School.where(name: school_names).pluck(:name, :id)
                 #  options = Hash[*schools.flatten] # #{"Jane" => 2, "John" => 1}
                 #  importer.batch_replace(:school_id, options)

                     #  importer.csv_lines.map! { |row| row << importer.model.school_id}
                      # importer.headers.merge!({:"school_id" => :school_id})
                       
                       
                   },
                   after_batch_import: ->(importer) {
                       Program.where(prog_title: "prog_title").delete_all
                    },
  :template_object => ActiveAdminImport::Model.new(
  #:school_id => nil,
  #:hint => "file will be imported with such header format: 'body','title','author'",
  # mass import
  :csv_headers => ["prog_title", "description", "subjectarea_id", "prog_level", "school_id", "duration", "delivery_method", "open_suny",  "synchronous",  "tutoring", "concierge", "experiential_learning", "plas", "accelerated", "level_expanded", "sed", "apply_now_url", "slug", "cat_id", "ranku_id", "active", "asynchronous"]
#  :csv_headers => ["prog_title", "description", "summary", "subjectarea_id", "prog_level", "levelabb_id", "duration", "delivery_method", "prerequisites", "program_url", "registration_url",  "open_suny", "per_courses_online", "synchronous", "synchronous_text", "tutoring", "tutoring_name", "tutoring_phone", "tutoring_email", "tutoring_url", "helpdesk", "helpdesk_phone", "helpdesk_email", "helpdesk_url", "concierge", "concierge_phone", "concierge_name", "concierge_email", "experiential_learning", "experiential_text", "plas", "plas_text", "accelerated", "accelerated_text", "level_expanded", "sed", "apply_now_url"] 
  )
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :prog_title, :description, :subjectarea_id, :prog_level, :school_id, :duration, :delivery_method,  :open_suny, :synchronous, :tutoring, :concierge, :experiential_learning, :plas, :accelerated, :level_expanded, :sed, :apply_now_url, :slug, :cat_id, :ranku_id, :active, :asynchronous, :subject_area, :subject_area_2, :subject_area_3, :meta_keywords, :meta_desc, :das_area, :prog_courses
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  
  #filter :school_id, as: :select, :collection => School.pluck(:name, :id)

  filter :ranku_id
  filter :prog_title
  filter :description
   filter :school_id, as: :select, :collection => School.pluck(:name, :id).sort
   filter :open_suny, :as => :select, collection: Program.options_for_open_suny
   filter :level_expanded, :as => :select, :collection => ["Advanced Certificate","Associate of Applied Science","Associate of Arts","Associate of Science","Bachelor of Arts","Bachelor of Business", "Bachelor of Business Administration","Bachelor of Nursing","Bachelor of Professional Studies","Bachelor of Science","Bachelor of Technology","Certificate","Doctor of Education","Doctor of Nursing Practice","Doctor of Philosophy","Doctorate","Master of Arts","Master of Arts in Teaching","Master of Business Administration","Master of Education","Master of Engineering","Master of Music","Master of Public Health","Master of Science","Master of Science in Education","Master of Social Work","Masters of Arts in Teaching","Undergraduate Certificate"]
   filter :subject_area, as: :select, collection: Program.options_for_subject_area
   filter :subject_area_2, as: :select, collection: Program.options_for_subject_area
   filter :subject_area_3, as: :select, collection: Program.options_for_subject_area
   filter :das_area, as: :select, collection: Program.options_for_das_area
   filter :prog_level
   filter :synchronous
   filter :asynchronous
   filter :delivery_method, :as => :select, collection: Program.options_for_delivery_method
   filter :active
   filter :duration
   filter :tutoring, :as => :select, :collection => [["Yes", true], ["No", false]]
   filter :concierge, :as => :select, :collection => [["Yes", true], ["No", false]]
   filter :experiential_learning, :as => :select, :collection => [["Yes", true], ["No", false]]
   filter :accelerated, :as => :select, :collection => [["Yes", true], ["No", false]]
   filter :plas, :as => :select, :collection => [["Yes", true], ["No", false]]
   filter :sed
   
   
   


  form do |f|
  f.inputs "Program Details" do
    tabs do
      tab 'Program Overview', {class: 'ui-tabs-active'} do
        f.li "<li><div class='aa_label'><h3>What is the name of the program?</h3</div></li>".html_safe  
     f.text_field :prog_title
     f.hr
      f.li "<li><div class='aa_label'><h3>Which school is this program for?</h3</div></li>".html_safe 
      f.input :school_id, as: :select, :collection => School.pluck(:name, :id)
      f.hr
     f.li "<li><div class='aa_label'><h3>What type of degree is this?</h3</div></li>".html_safe
    f.input :level_expanded, :as => :select, :collection => ["Advanced Certificate","Associate of Applied Science","Associate of Arts","Associate of Science","Bachelor of Arts","Bachelor of Business", "Bachelor of Business Administration","Bachelor of Nursing","Bachelor of Professional Studies","Bachelor of Science","Bachelor of Technology","Certificate","Doctor of Education","Doctor of Nursing Practice","Doctor of Philosophy","Doctorate","Master of Arts","Master of Arts in Teaching","Master of Business Administration","Master of Education","Master of Engineering","Master of Music","Master of Public Administration","Master of Public Health","Master of Science","Master of Science in Education","Master of Social Work","Masters of Arts in Teaching","Undergraduate Certificate"]
    f.hr
    f.li "<li><div class='aa_label'><h3>What field of study is this program a part of? (Choose up to 3)</h3</div></li>".html_safe
    
    f.input :subject_area, as: :select, collection: Program.options_for_subject_area
    f.input :subject_area_2, as: :select, collection: Program.options_for_subject_area
    f.input :subject_area_3, as: :select, collection: Program.options_for_subject_area
    f.hr
     f.li "<li><div class='aa_label'><h3>Does this program belongs to a pathway?</h3</div></li>".html_safe
     f.input :das_area, as: :select, collection: Program.options_for_das_area
     f.hr
    f.li "<li><div class='aa_label_level'><h3>What degree level is this program?</h3</div></li>".html_safe 
   f.input :prog_level,  :as => :select,  collection: Program.options_for_prog_level
   f.hr
   f.li "<li><div class='aa_label_level'><h3>What format are the classes in?</h3</div></li>".html_safe 
      f.li "<li><div class='aa_label_level'><h4>Synchronous?</h4</div></li>".html_safe 
 f.input :synchronous, :as => :radio, :collection => [["Yes", true], ["No", false]], :input_html => { :class => 'toggle-radio' }
      f.li "<li><div class='aa_label_level'><h4>Asynchronous?</h4</div></li>".html_safe 
 f.input :asynchronous, :as => :radio, :collection => [["Yes", true], ["No", false]]
      end
      
      tab 'Program Description', {class: 'ui-tabs-active'} do
        f.li "<li><div class='aa_label_level'><h3>Briefly summarize this program</h3</div></li>".html_safe 
        f.input :description, as: :froala_editor
        f.hr
        f.li "<li><div class='aa_label_level'><h3>Metadata Keywords</h3</div></li>".html_safe 
        f.input :meta_keywords
        f.li "<li><div class='aa_label_level'><h3>Metadata Description</h3</div></li>".html_safe 
        f.input :meta_desc
      end
      tab 'Program Courses', {class: 'ui-tabs-active'} do
        f.li "<li><div class='aa_label_level'><h3>List program couses</h3</div></li>".html_safe 
        f.input :prog_courses, as: :froala_editor
      end
      tab 'Application Information', {class: 'ui-tabs-active'} do
        f.li "<li><div class='aa_label_level'><h3>What is the application URL?</h3</div></li>".html_safe 
        f.input :apply_now_url
      end
       tab 'Additional Info', {class: 'ui-tabs-active'} do
         f.li "<li><div class='aa_label_level'><h3>Course Delivery</h3</div></li>".html_safe 
         f.li "<li><div class='aa_label_level'><h4>What percentage of this degree is online?</h4</div></li>".html_safe 
         f.input :delivery_method, :as => :radio, collection: Program.options_for_delivery_method
         f.hr
         f.li "<li><div class='aa_label_level'><h3>Featured Programs</h3</div></li>".html_safe 
         f.li "<li><div class='aa_label_level'><h4>Is this a featured degree program, certificate, or endorsement?</h4</div></li>".html_safe 
         f.input :open_suny, :as => :radio, collection: Program.options_for_open_suny
       #  if f.program.open_suny == "SUNY Online"
         #  f.input :headline_text
           #f.input :button_text
        # end
         f.hr
         f.li "<li><div class='aa_label_level'><h3>Online Tutoring</h3</div></li>".html_safe 
         f.li "<li><div class='aa_label_level'><h4>Do students in this program have access to online tutoring support?</h4</div></li>".html_safe 
           f.input :tutoring, :as => :radio, :collection => [["Yes", true], ["No", false]]
           f.hr
         f.li "<li><div class='aa_label_level'><h3>Personal Concierge</h3</div></li>".html_safe 
         f.li "<li><div class='aa_label_level'><h4>Will this degree program have one person who acts as a signle point of contact for any and all questions?</h4</div></li>".html_safe 
           f.input :concierge, :as => :radio, :collection => [["Yes", true], ["No", false]]
           f.hr
         #f.input :tutoring, :as => :radio, :collection => [["Yes", true], ["No", false]]
         f.li "<li><div class='aa_label_level'><h3>Applied Learning</h3</div></li>".html_safe 
         f.li "<li><div class='aa_label_level'><h4>Does this degree program participate in field experiences such as interships, clinical placements, and service learning?</h4</div></li>".html_safe 
         f.input :experiential_learning, :as => :radio, :collection => [["Yes", true], ["No", false]]
         f.hr
         f.li "<li><div class='aa_label_level'><h3>Is this a program to graduate early?</h3</div></li>".html_safe 
         f.li "<li><div class='aa_label_level'><h4>Does this degree program allow students ti earn their dgree ahead of schedule?</h4</div></li>".html_safe 
         f.input :accelerated, :as => :radio, :collection => [["Yes", true], ["No", false]]
         f.hr
         f.li "<li><div class='aa_label_level'><h3>Prior Learning Assessment</h3</div></li>".html_safe 
         f.li "<li><div class='aa_label_level'><h4>Can students get college credit for experience gained at school or in the workforce in this degree program?</h4</div></li>".html_safe 
         f.input :plas, :as => :radio, :collection => [["Yes", true], ["No", false]]
         f.hr
         f.li "<li><div class='aa_label_level'><h4>How many credits is this program?</h4</div></li>".html_safe 
          f.input :duration
          f.hr  
       f.li "<li><div class='aa_label_level'><h4>SED Code</h4</div></li>".html_safe 
         f.input :sed
         f.hr
         f.li "<li><div class='aa_label_level'><h3>Ranku ID</h3</div></li>".html_safe 
         f.li "<li><div class='aa_label_level'><h4>This code is used to content to slate.</h4</div></li>".html_safe 
         f.input :ranku_id
         f.hr
         f.li "<li><div class='aa_label_level'><h3>Should this program be displayed on the webiste?</h3</div></li>".html_safe 
         f.input :active, :as => :radio, :collection => [["Yes", true], ["No", false]]
       end
    end
    





 
#f.input :subject_area, as: :check_boxes, :collection => [["Arts", "arts"],["Behavioral Science", "behavioral_science"],["Business", "business"],["Computer Science", "computer-science"],["Criminal Justice Law", "criminal-justice-law"],["Education", "education"],["Health Sciences", "health-sciences"],["Journalism Communications", "journalism--communications"],["Liberal Arts", "arts.liberal"],["Public Administration Community Service", "public-admin--community-service"],["Science Technology", "science--technology"],["Social Sciences", "social-sciences"],["Travel Tourism", "travel--tourism"]], input_html: {hidden_fields: false, required: true, allow_blank: false, hint: 'Please enter an object'}
  #f.input :cat_id, as: :select, :collection => Category.pluck(:name, :id)
  



  end
  f.actions
  end



#filter :school_id, as: :select, :collection => School.pluck(:name, :id).sort

csv do
    column :id
    column :ranku_id
    column :school_id do |program|
      if program.school_id?
        School.get_name(program.school_id)
      else
        "No school listed"
      end
    end
    column :prog_title
    column :description
    column :open_suny
    column :level_expanded

    column :subject_area
    column :subject_area_2
    column :subject_area_3
    
    column :prog_level
    column :synchronous
    column :asynchronous
    column :delivery_method
    column :active
    column :duration
    column :tutoring
    column :concierge
    column :experiential_learning
    column :accelerated
    column :plas
    column :sed

end    
  

  index do
     id_column
     column :sed
     column :prog_title
     column :school_id do |program|
       program.school.name
     end

     column :level_expanded
    actions
  end
  
  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
    

  end


end
