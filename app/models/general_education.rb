class GeneralEducation < ActiveRecord::Base
  has_many :courses
  
  def self.options_for_select
    order('name').map { |e| [e.name, e.name] }
  end
  
  
  
end
