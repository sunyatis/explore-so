class Catalog < ActiveRecord::Base
  
  has_many :courses, dependent: :destroy 

  
  
  def self.options_for_select
    order('id').map { |e| [e.name, e.id] }
  end
  
  def num_courses
    courses.count
  end

end
