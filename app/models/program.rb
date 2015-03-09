class Program < ActiveRecord::Base
  belongs_to :school, :foreign_key => 'school_id', :class_name => "School"
  belongs_to :level_abb, :foreign_key => 'levelabb_id', :class_name => "LevelAbb"
  belongs_to :subject_area, :foreign_key => 'subjectarea_id' , :class_name => "SubjectArea"
  
  
   filterrific default_filter_params: { :sorted_by => 'prog_title_asc' },
               available_filters: [
                 :sorted_by,
                 :search_query,
                 :with_school_id
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
     num_or_conditions = 1

     where(
       terms.map {
         or_clauses = [
           "LOWER(programs.prog_title) LIKE ?"
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
     when /^prog_title_/
       order("programs.prog_title #{ direction }")
     when /^prog_level_/
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


   def self.options_for_sorted_by
     [
       ['Registration date (newest first)', 'prog_title_desc'],
       ['Registration date (oldest first)', 'prog_title_asc'],
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