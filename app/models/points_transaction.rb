class PointsTransaction < ActiveRecord::Base
  belongs_to :school
  has_paper_trail
  
end
