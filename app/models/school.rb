class School < ActiveRecord::Base
  has_many :points_transactions
  has_many :users
end
