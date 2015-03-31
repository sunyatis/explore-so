class School < ActiveRecord::Base
    extend FriendlyId
    
    has_many :users
    has_many :programs
    has_many :courses


    #has_paper_trail


    def self.options_for_select
      order('id').map { |e| [e.name, e.id] }
    end
    
    #friendly id
     friendly_id :generate_custom_slug, use: :slugged

     def generate_custom_slug
         "#{name}"
     end
  
  
  
end
