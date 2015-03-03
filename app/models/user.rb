class User < ActiveRecord::Base
  
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  ROLES = ['System Administrator', 'Power User', 'CPD Campus Contact', 'ITEC Campus Contact', 'Campus Administrator', 'ITEC Administrator', 'CPD Administrator']
         
         def role?(r)
           role.include? r.to_s
         end       
         
end
