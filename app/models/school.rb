class School < ActiveRecord::Base
  has_many :points_transactions
  has_many :users
  
  has_paper_trail
end
