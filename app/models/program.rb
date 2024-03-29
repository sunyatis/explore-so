class Program < ActiveRecord::Base
  extend FriendlyId
  
  belongs_to :school, :foreign_key => 'school_id', :class_name => "School"
  belongs_to :level_abb, :foreign_key => 'levelabb_id', :class_name => "LevelAbb"
  #belongs_to :subject_area, :foreign_key => 'subjectarea_id' , :class_name => "SubjectArea"
  belongs_to :category, :foreign_key => 'cat_id', :class_name => "Category"
  belongs_to :pathway, :foreign_key => 'pathway_id'
 
  has_paper_trail
 
 
  # default for will_paginate
   paginates_per 700
  
   filterrific default_filter_params: { :sorted_by => 'prog_title_asc' },
               available_filters: [
                 :sorted_by,
                 :search_query,
                 :with_school_id,
                 :with_prog_level,
                 :with_subject,
                 #:with_subject_area_id,
                 :with_subject_area,
                 :with_prog_title,
                 :with_delivery,
                 :with_os,
                 :with_helpdesk,
                 :with_concierge,
                 :with_synchronous,
                 :with_experiential_learning,
                 :with_plas,
                 :with_accelerated,
                 :with_tutoring,
                 :with_category,
                 :with_das_area,
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
       ('%' + e.gsub('*', '%') + '%').gsub(/%+/, '%')
     }
     # configure number of OR conditions for provision
     # of interpolation arguments. Adjust this if you
     # change the number of OR conditions.
     num_or_conditions = 2

     where(
       terms.map {
         or_clauses = [
           "LOWER(programs.prog_title) LIKE ?",
           "LOWER(programs.description) LIKE ?"
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
       order("programs.open_suny desc, programs.prog_title asc ")
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
   scope :with_prog_level, lambda { |prog_levels|
     where(:prog_level => [*prog_levels])
   }
#   scope :with_subject_area_id, lambda { |subjectarea_ids|
#     where(:subjectarea_id => [*subjectarea_ids])
#   }
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
    scope :with_synchronous, lambda { |synchronouses| 
      where(:synchronous => [*synchronouses])
    }
    scope :with_experiential_learning, lambda { |experiential_learnings| 
      where(:experiential_learning => [*experiential_learnings])
    }
    scope :with_plas, lambda { |plases| 
      where(:plas => [*plases])
    }
    scope :with_accelerated, lambda { |accelerateds|
      where(:accelerated => [*accelerateds])
    }
    scope :with_tutoring, lambda { |tutorings|
      where(:tutoring => [*tutorings])
    }
    scope :with_das_area, lambda { |das_areas|
      where(:das_area => [*das_areas])
    }
    scope :with_subject_area, ->(subjectarea){ 
       return nil  if subjectarea.blank?
       puts subjectarea
       # condition query, parse into individual keywords
       terms = subjectarea.split(/\s+/)
       puts terms
  #    # configure number of OR conditions for provision
  #    # of interpolation arguments. Adjust this if you
  #    # change the number of OR conditions.
      num_or_conditions = 3
      
      terms = terms.map { |e|
        (e.gsub('*', '%') + '%').gsub(/%+/, '%')
      }
  puts terms
      where(
       terms.map { |e|
         or_clauses = [
            "programs.subject_area LIKE ?", 
             "programs.subject_area_2 LIKE ?", 
             "programs.subject_area_3 LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conditions }.flatten
      )
    }
    
    scope :with_category, ->(categories){ 
       return nil  if categories.blank?

       # condition query, parse into individual keywords
       terms = categories.join(" ").split(/\s+/)

  #    # configure number of OR conditions for provision
  #    # of interpolation arguments. Adjust this if you
  #    # change the number of OR conditions.
      num_or_conditions = 1
  #
      where(
       terms.map { |e|
         or_clauses = [
            "programs.cat_id LIKE ?", 
            "programs.cat_id LIKE \'%, #{e}\'", 
            "programs.cat_id LIKE \'#{e},%\'", 
            "programs.cat_id LIKE \'%, #{e},%\'"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conditions }.flatten
      )
    }
    

   def self.options_for_sorted_by
     [
       ['Program Tite (A-Z)', 'prog_title_asc'],
       ['Program Title (Z-A)', 'prog_title_desc'],
       ['School', 'school_id_asc'],
     ]
   end
   def self.options_for_prog_level
     #order('id').map { |e| [e.level_expanded, e.id] }.uniq
     Program.pluck(:prog_level).uniq
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
   def self.options_for_das_area
     [
      ['Accounting', 'accounting'],
      ['Business', 'business'],
      ['Computer Science & IT', 'computerscience_it'],
      ['Criminal Justice', 'criminal_justice'], 
      ['Education', 'Education'],
      ['Engineering', 'engineering'],
      ['General Studies', 'general_studies'],
      ['Graduate Degrees', 'graduate_degrees'],
      ['Healthcare', 'healthcare'],
      ['Psychology', 'psychology'],
      ['Security Studies', 'security_studies'],
      
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
   def self.options_for_synchronous
     [
       ['Yes', 't'],
       ['No', 'f'],
     ]
  end
  def self.options_for_experiential_learning
     [
       ['Yes', 't'],
       ['No', 'f'],
     ]
  end
  def self.options_for_plas
     [
       ['Yes', 't'],
       ['No', 'f'],
     ]
  end
  def self.options_for_accelerated
    [
       ['Yes', 't'],
       ['No', 'f'],
    ]
  end
  def self.options_for_tutoring
    [
       ['Yes', 't'],
       ['No', 'f'],
    ]
  end
  def self.options_for_subject_area
    [
       ['Arts & Humanities', 'arts'],
       ['Behavioral Science', 'behavioral_science'],
       ['Business', 'business'],
       ['Climate & Sustainability', 'climate--sustainability'],
       ['Computer Science', 'computer-science'],
       ['Criminal Justice & Law', 'criminal-justice-law'],
       ['Education', 'education'],
       ['General Studies', 'bachelor-of-general-studies'],
       ['Health Sciences', 'health-sciences'],
       ['IT & Technology', 'information_technology'],
       ['Journalism & Communications', 'journalism--communications'],
       ['Liberal Arts', 'arts.liberal'],
       ['Public Administration & Community Service', 'public-admin--community-service'],
       ['Science & Technology', 'science--technology'],
       ['Social Sciences', 'social-sciences'],
       ['Travel & Tourism', 'travel--tourism'],
       
    ]
    end
    def self.options_for_prog_level
      [
        ['Certificate', 'certificate'],
         ['Associate', 'associate'],
         ['Bachelor', 'bachelor'],
         ['Master', 'master'],     
         ['Advanced Certificate', 'advanced-certificate'],
         ['Doctorate', 'doctorate']

      ]
    end
      def self.options_for_delivery_method
        [
           ['100%', '100% Online'],
           ['75%', '75% Online'],
           ['50', '50% Online'],
        ]
      
  end
    def self.options_for_open_suny
      [
         ['SUNY Online Plus', 'Open SUNY'],
         ['No', 'No'],
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
  # def get_school_name(id)
  #   School.friendly.find(params[:school_id]).name
  # end
   # Get School name
  # def get_level_abb_name(id)
    # LevelAbb.find(id).name
  # end
   

   #friendly id
   #friendly_id :generate_custom_slug #, use: :slugged
   friendly_id :generate_custom_slug, use: :slugged
   
   def should_generate_new_friendly_id?
     new_record? || slug.blank?
   end
   def get_school_name(id)
     School.friendly.find(id).name
   end

  def generate_custom_slug
      "#{get_school_name(school_id)}-#{prog_title}-#{prog_level}-#{ranku_id}"
  end
  def get_name(id)
     School.find(id).name
  end
  
end
