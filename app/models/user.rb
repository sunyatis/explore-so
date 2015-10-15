class User < ActiveRecord::Base
   belongs_to :school
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  ROLES = ['System Administrator', 'Campus Contact']
         
         def role?(r)
           role.include? r.to_s
         end   

         
end
