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
     
     def find_campus_type(id)
       @campus = School.where(id: id).pluck(:campus_type)
       result = @campus.join(" ").downcase.parameterize 
       return result
     end
     def any_progs(id)
       @progs = Program.where(school_id: id).count
     end
     def list_progs(id)
       @list_progs = Program.where(school_id: id).pluck(:prog_level).uniq
       result = @list_progs.join(" ")
       return result
     end  
     def associate(id)
       @associate = Program.where(school_id: id, prog_level: "associate").count
     end
     def bachelor(id)
       @bachelor = Program.where(school_id: id, prog_level: "bachelor").count
     end
     def master(id)
       @master = Program.where(school_id: id, prog_level: "master").count
     end
     def certificate(id)
       @certificate = Program.where(school_id: id, prog_level: "certificate").count
     end
     def advanced_certificate(id)
       @advanced_certificate = Program.where(school_id: id, prog_level: "advanced-certificate").count
     end
     def doctorate(id)
       @doctorate = Program.where(school_id: id, prog_level: "doctorate").count
     end
  
     def self.options_for_school_select
        School.where("courses.school_id = schools.id").order(:id).pluck(:id).uniq
     end
     
     #get school name
     def self.get_name(id)
        School.find(id).name
     end
  
  
end
