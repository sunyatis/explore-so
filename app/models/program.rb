class Program < ActiveRecord::Base
  extend FriendlyId
  
  belongs_to :school, :foreign_key => 'school_id', :class_name => "School"
  belongs_to :level_abb, :foreign_key => 'levelabb_id', :class_name => "LevelAbb"
  belongs_to :subject_area, :foreign_key => 'subjectarea_id' , :class_name => "SubjectArea"
 
  has_paper_trail
 
 
  # default for will_paginate
    paginates_per 10
  
   filterrific default_filter_params: { :sorted_by => 'prog_title_asc' },
               available_filters: [
                 :sorted_by,
                 :search_query,
                 :with_school_id,
                 :with_level,
                 :with_subject,
                 :with_subject_area_id,
                 :with_prog_title,
                 :with_delivery,
                 :with_os,
                 :with_helpdesk,
                 :with_concierge
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
       order(" programs.open_suny desc, programs.prog_title #{ direction }")
     when /^prog_level_/
       order("LOWER(programs.level) #{ direction }")
     when /^school_id_/
       order("programs.school_id #{ direction }")
     else
       raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
     end
   }
   scope :with_school_id, lambda { |school_ids|
     where(:school_id => [*school_ids])
   }
   scope :with_level, lambda { |level_expandeds|
     where(:level_expanded => [*level_expandeds])
   }
   scope :with_subject_area_id, lambda { |subjectarea_ids|
     where(:subjectarea_id => [*subjectarea_ids])
   }
    scope :with_prog_title, lambda { |prog_titles|
      where(:prog_title => [*prog_titles])
    }
    scope :with_delivery, lambda { |delivery_methods|
      where(:delivery_method => [*delivery_methods])
    }
    scope :with_os, lambda { |open_sunys|
      where(:open_suny => [*open_sunys])
    }
    scope :with_helpdesk, lambda { |helpdesks| 
      where(:helpdesk => [*helpdesks])
    }
    scope :with_concierge, lambda { |concierges| 
      where(:concierge => [*concierges])
    }
   
   def self.options_for_sorted_by
     [
       ['Program Tite (A-Z)', 'prog_title_asc'],
       ['Program Title (Z-A)', 'prog_title_desc'],
       ['School', 'school_id_asc'],
     ]
   end
   def self.options_for_level
     #order('id').map { |e| [e.level_expanded, e.id] }.uniq
     Program.pluck(:level_expanded).uniq
   end
   def self.options_for_prog_title
     #order('id').map { |e| [e.level_expanded, e.id] }.uniq
     Program.pluck(:prog_title).uniq
   end
   def self.options_for_delivery_method
      #order('id').map { |e| [e.level_expanded, e.id] }.uniq
     Program.pluck(:delivery_method).uniq
   end
   def self.options_for_os
     [
      ['Yes', 'Yes'],
       ['No', 'No'],
     ]
   end
   def self.options_for_helpdesk
      [
       ['Yes', 't'],
        ['No', 'f'],
      ]
   end
   def self.options_for_concierge
     [
       ['Yes', 't'],
       ['No', 'f'],
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
   
  def admin_permalink
     admin_post_path(self)
   end
   
   # Get School name
   def get_school_name(id)
     School.find(id).name
   end
   # Get School name
   def get_level_abb_name(id)
     LevelAbb.find(id).name
   end
   
   #friendly id
   friendly_id :generate_custom_slug, use:  [:slugged, :finders]

   def generate_custom_slug
       "#{get_school_name(school_id)}-#{prog_title}-#{get_level_abb_name(levelabb_id)}"
   end
  
end
