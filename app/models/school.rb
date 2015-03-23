class School < ActiveRecord::Base

    has_many :users
    has_many :programs
    has_many :courses


    #has_paper_trail


    def self.options_for_select
      order('id').map { |e| [e.name, e.id] }
    end
  
  
  
end
