class PathwaysController < ApplicationController

  def index
    @pathways = Pathway.where(:landing_page => 'index').uniq
    render 'index', layout: false
    #@programs = Program.where(:open_suny => 'Open SUNY').uniq
  end

def accounting 
  @pathways = Pathway.where(:landing_page => 'accounting').uniq
  render 'accounting', layout: false
  #@programs = Program.where(:open_suny => 'Open SUNY').uniq
end

def business
  @pathways = Pathway.where(:landing_page => 'business').uniq
  render 'business', layout: false
  
end

def computerscience_it
  @pathways = Pathway.where(:landing_page => 'computerscience_it').uniq
  render 'computerscience_it', layout: false
  #@programs = Program.where(:open_suny => 'Open SUNY').uniq
end

def criminal_justice
   @pathways = Pathway.where(:landing_page => 'criminal_justice').uniq
  render 'criminal_justice', layout: false
  #@programs = Program.where(:open_suny => 'Open SUNY').uniq
end
def data_science
   @pathways = Pathway.where(:landing_page => 'data_science').uniq
  render 'data_science', layout: false
end
def education
   @pathways = Pathway.where(:landing_page => 'education').uniq
  render 'education', layout: false
end
def engineering
   @pathways = Pathway.where(:landing_page => 'engineering').uniq
  render 'engineering', layout: false
end

def general_studies
   @pathways = Pathway.where(:landing_page => 'general_studies').uniq
  render 'general_studies', layout: false
end
def graduate_degrees
   @pathways = Pathway.where(:landing_page => 'graduate_degrees').uniq
  render 'graduate_degrees', layout: false
end
def healthcare
   @pathways = Pathway.where(:landing_page => 'healthcare').uniq
  render 'healthcare', layout: false
end
def psychology
   @pathways = Pathway.where(:landing_page => 'psychology').uniq
  render 'psychology', layout: false
end
def security_studies
   @pathways = Pathway.where(:landing_page => 'security_studies').uniq
  render 'security_studies', layout: false
end




  private

    def pathway_params
      params.require(:pathway).permit(:title, :headline, :description, :learn_your_way_text, :best_fit_link_1, :best_fit_link_2, :best_fit_link_3, :meta_description, :meta_keywords, :page_title, :pathway_title, :landing_page)
    end
    


    
end

