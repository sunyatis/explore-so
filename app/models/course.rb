class Course < ActiveRecord::Base
  extend FriendlyId
  
  belongs_to :subject_area, :foreign_key => 'subjectarea_id' , :class_name => "SubjectArea"
  belongs_to :school, :foreign_key => 'school_id', :class_name => "School"
  belongs_to :catalog, :foreign_key => 'catalog_id', :class_name => "Catalog"
  belongs_to :general_education, :foreign_key => 'generaleducation_id' , :class_name => "GeneralEducation"
  belongs_to :category, :foreign_key => 'cat_id', :class_name => "Category"

  has_paper_trail
  
  
  filterrific default_filter_params: { :sorted_by => 'title_asc' },
               available_filters: [
                 :sorted_by,
                 :search_query,
                 :with_school_id,
                 :with_catalog_id,
                 :with_generaleducation_id,
                 :with_start_date_gte,
                 :with_start_date,
                 :with_subject_area_id,
                 :with_course_area,
                 :with_level,
                 :with_credit,
                 :with_category
               ]

   # default for will_paginate
   #self.per_page = 10

   scope :search_query, ->(query){ 
     return nil  if query.blank?
     puts query.to_s
     # condition query, parse into individual keywords
     terms = query.downcase.split(/\s+/)
     puts terms
     # replace "*" with "%" for wildcard searches,
     # append '%', remove duplicate '%'s
     #terms = terms.map { |e|
      # (e.gsub('*', '%') + '%').gsub(/%+/, '%')
     #}
     # configure number of OR conditions for provision
     # of interpolation arguments. Adjust this if you
     # change the number of OR conditions.
     num_or_conditions = 2

     where(
       terms.map {
         or_clauses = [
           "LOWER(courses.title) LIKE ?",
           "LOWER(courses.description) LIKE ?"
         ].join(' OR ')
         "(#{ or_clauses })"
       }.join(' AND '),
       *terms.map { |e| [e] * num_or_conditions }.flatten
     )
   }

   scope :sorted_by, lambda { |sort_option|
     # extract the sort direction from the param value.
     direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
     case sort_option.to_s
     when /^title_/
       order("courses.title #{ direction }")
     when /^start_date_/
      order("courses.start_date #{ direction }")
     when /^credit_/
      order("courses.credit #{ direction }")
     when /^level_/
       order("LOWER(programs.level) #{ direction }")
     else
       raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
     end
   }
   scope :with_school_id, lambda { |school_ids|
     where(:school_id => [*school_ids])
   }
   scope :with_start_date, lambda { |start_date|
    }
   scope :with_start_date_gte, lambda { |start_date|
     where('courses.start_date >= ?', start_date)
   }
   scope :with_catalog_id, lambda { |catalog_ids|
     where(:catalog_id => [*catalog_ids])
   }
  scope :with_generaleducation_id , ->(generaleducation_ids){ 
      return nil  if generaleducation_ids.blank?

      # condition query, parse into individual keywords
      terms = generaleducation_ids.join(" ").split(/\s+/)

 #    # configure number of OR conditions for provision
 #    # of interpolation arguments. Adjust this if you
 #    # change the number of OR conditions.
     num_or_conditions = 1
 #
     where(
      terms.map { |e|
        or_clauses = [
           "courses.generaleducation_id LIKE ?", 
           "courses.generaleducation_id LIKE \'%, #{e}\'", 
           "courses.generaleducation_id LIKE \'#{e},%\'", 
           "courses.generaleducation_id LIKE \'%, #{e},%\'"
         ].join(' OR ')
         "(#{ or_clauses })"
       }.join(' AND '),
       *terms.map { |e| [e] * num_or_conditions }.flatten
     )
   }

  scope :with_subject_area_id, lambda { |subjectarea_ids|
     where(:subjectarea_id => [*subjectarea_ids])
   }
   scope :with_course_area, lambda { |course_areas|
       where(:course_area => [*course_areas])
     }
  scope :with_level, lambda { |levels|
    where(:level => [*levels])
  }
  scope :with_credit, lambda { |credits|
    where(:credit => [*credits])
  }
  scope :with_category, ->(categories){ 
     return nil  if categories.blank?

     # condition query, parse into individual keywords
     terms = categories.join(" ").split(/\s+/)

#    # configure number of OR conditions for provision
#    # of interpolation arguments. Adjust this if you
#    # change the number of OR conditions.
    num_or_conditions = 1
  #  Course.where("courses.cat_id IN ('2')")

   where(
    terms.map { |e|
      or_clauses = [
         "courses.cat_id IN ('#{e}')"#, 
        # "courses.cat_id LIKE \'%, #{e}\'", 
        # "courses.cat_id LIKE \'#{e},%\'", 
        # "courses.cat_id LIKE \'%, #{e},%\'"
       ].join(' OR ')
       "(#{ or_clauses })"
     }.join(' AND '),
     *terms.map { |e| [e] * num_or_conditions }.flatten
   )
  }

   def self.options_for_sorted_by
     [
       ['Start Date DESC', 'start_date_desc'],
       ['Start Date ASC', 'start_date_asc'],
       ['Title ASC', 'title_asc'],
       ['Credits', 'credit_asc'],
     ]
   end
   
   def self.options_for_level_select
     Course.pluck(:level).uniq
   end
   def self.options_for_credit_select
      Course.pluck(:credit).uniq
   end
   def self.options_for_course_area_select
      Course.order(:course_area).pluck(:course_area).uniq
   end

  

 #  scope :search_query, lambda { |query|
 #    return nil  if query.blank?
 #    # condition query, parse into individual keywords
 #    terms = query.downcase.split(/\s+/)
 #    # replace "*" with "%" for wildcard searches,
 #    # append '%', remove duplicate '%'s
 #    terms = terms.map { |e|
 #      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
 #    }
 #    # configure number of OR conditions for provision
 #    # of interpolation arguments. Adjust this if you
 #    # change the number of OR conditions.
 #    num_or_conditions = 3
 #    where(
 #      terms.map {
 #        or_clauses = [
 #          "LOWER(students.first_name) LIKE ?",
 #          "LOWER(students.last_name) LIKE ?",
 #          "LOWER(students.email) LIKE ?"
 #        ].join(' OR ')
 #        "(#{ or_clauses })"
 #      }.join(' AND '),
 #      *terms.map { |e| [e] * num_or_conditions }.flatten
 #    )
 #  }
 
 #Convert time on import
 def self.strptime(str)
   return nil unless str.present?
   #puts str
   #puts "here"
   if str == "start_date"
     return "start_date"
   end
   month, day, year = str.to_s.strip.split('/')
   if year.to_s.length == 2
     #puts "here2"
      Date.strptime(str.to_s.strip, '%m/%d/%y')
   elsif year.to_s.length == 4
     #puts "here4"
     Date.strptime(str.to_s.strip, '%m/%d/%y')
   end
 end

  
 def admin_permalink
    admin_post_path(self)
end

# Get Catalog name
def get_catalog_name(id)
  Catalog.find(id).name
end
# Get School name
def get_school_name(id)
  School.find(id).name
end


#friendly ids
friendly_id :generate_custom_slug, use:  [:slugged, :finders]

def generate_custom_slug
    "#{get_school_name(school_id)}-#{title}-#{code}-#{section}-#{get_catalog_name(catalog_id)}"
end
  
end
