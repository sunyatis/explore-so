class School < ActiveRecord::Base
    extend FriendlyId
    
    has_many :users
    has_many :programs
    has_many :courses

    has_attached_file :image, :styles => { :medium => "700x900>", :thumb => "120x80>"}, default_url: "/images/:style/missing.png"
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
  
  
  
end
