class School < ActiveRecord::Base
    extend FriendlyId
    
    has_many :users
    has_many :programs
    has_many :courses

    has_attached_file :image, :styles => { :medium => "700x900>", :small => "90x90>"}, default_url: "/assets/images/:style/missing.png"
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    #has_paper_trail


    def self.options_for_select
      order('id').map { |e| [e.name, e.id] }
    end
    
    #friendly id
     friendly_id :generate_custom_slug, use:  [:slugged, :finders]

     def generate_custom_slug
         "#{name}"
     end
  
     def self.options_for_school_select
        School.where("courses.school_id = schools.id").order(:id).pluck(:id).uniq
     end
  
end
