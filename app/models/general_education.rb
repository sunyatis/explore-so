class GeneralEducation < ActiveRecord::Base
  
  
  def self.options_for_select
    order('name').map { |e| [e.name, e.name] }
  end
  
  
  
end
