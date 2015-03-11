class Catalog < ActiveRecord::Base
  
  has_many :courses
  
  def self.options_for_select
    order('id').map { |e| [e.name, e.id] }
  end
  
  
  
end
