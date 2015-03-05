class School < ActiveRecord::Base
  has_many :points_transactions
  has_many :users
  
  has_paper_trail


  def self.options_for_select
    order('LOWER(id)').map { |e| [e.name, e.id] }
  end
  
end
