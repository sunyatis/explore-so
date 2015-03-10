class Course < ActiveRecord::Base
  belongs_to :subject_area, :foreign_key => 'subjectarea_id' , :class_name => "SubjectArea"
  belongs_to :school, :foreign_key => 'school_id', :class_name => "School"
  belongs_to :catalog, :foreign_key => 'catalog_id', :class_name => "Catalog"
  
  
  
  
  
  
  
end
