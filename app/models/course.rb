class Course < ActiveRecord::Base
  belongs_to :subject_area, :foreign_key => 'subjectarea_id' , :class_name => "SubjectArea"
  belongs_to :school, :foreign_key => 'school_id', :class_name => "School"
  belongs_to :catalog, :foreign_key => 'catalog_id', :class_name => "Catalog"
  belongs_to :general_education, :foreign_key => 'generaleducation_id' , :class_name => "GeneralEducation"
  
  filterrific default_filter_params: { :sorted_by => 'title_asc' },
               available_filters: [
                 :sorted_by,
                 :search_query,
                 :with_school_id,
                 :with_catalog_id,
                 :with_generaleducation_id
               ]

   # default for will_paginate
   #self.per_page = 10

   scope :search_query, ->(query){ 
     return nil  if query.blank?
     # condition query, parse into individual keywords
     terms = query.downcase.split(/\s+/)
     # replace "*" with "%" for wildcard searches,
     # append '%', remove duplicate '%'s
     terms = terms.map { |e|
       (e.gsub('*', '%') + '%').gsub(/%+/, '%')
     }
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
     when /^level_/
       order("LOWER(programs.level) #{ direction }")
     else
       raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
     end
   }
   scope :with_school_id, lambda { |school_ids|
     where(:school_id => [*school_ids])
   }
   scope :with_created_at_gte, lambda { |ref_date|
     where('points_transactions.created_at >= ?', ref_date)
   }
   scope :with_catalog_id, lambda { |catalog_ids|
     where(:catalog_id => [*catalog_ids])
   }
    scope :with_generaleducation_id,  lambda { |generaleducation_ids|
  #  return nil  if general_educations.blank?
  #  # condition query, parse into individual keywords
  #  terms = general_educations.downcase.split(/,/)
  #  # replace "*" with "%" for wildcard searches,
  #  # append '%', remove duplicate '%'s
  #  terms = terms.map { |e|
  #    (e.gsub('*', '%') + '%').gsub(/%+/, '%')
  #  }
  #  # configure number of OR conditions for provision
  #  # of interpolation arguments. Adjust this if you
  #  # change the number of OR conditions.
  #  num_or_conditions = 2
  #
  #  where(
  #    terms.map {
  #      or_clauses = [
  #        "LOWER(courses.general_education) LIKE ?",
  #        "LOWER(courses.general_education) LIKE ?"
  #      ].join(' OR ')
  #      "(#{ or_clauses })"
  #    }.join(' AND '),
  #    *terms.map { |e| [e] * num_or_conditions }.flatten
  #  )
  
    #return nil if generaleducation_ids == [""]
    where(generaleducation_id: [*generaleducation_ids])

     # where(general_education: { name: general_education }).joins(:general_education)
    }



   def self.options_for_sorted_by
     [
       ['Registration date (newest first)', 'title_desc'],
       ['Registration date (oldest first)', 'title_asc'],
     ]
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

  
  
  
end
