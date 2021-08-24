class PathwaysController < ApplicationController

  def index
    render 'index', layout: false
    #@programs = Program.where(:open_suny => 'Open SUNY').uniq
  end

def accounting 
  render 'accounting', layout: false
  #@programs = Program.where(:open_suny => 'Open SUNY').uniq
end
def accounting1 
  render 'accounting1', layout: false
  #@programs = Program.where(:open_suny => 'Open SUNY').uniq
end
def accounting1 
  render 'accounting1', layout: false
  #@programs = Program.where(:open_suny => 'Open SUNY').uniq
end
def business
  @pathways = Pathway.where(:landing_page => 'business').uniq
  render 'business', layout: false
  
end

def computerscience_it
  render 'computerscience_it', layout: false
  #@programs = Program.where(:open_suny => 'Open SUNY').uniq
end

def criminal_justice
  render 'criminal_justice', layout: false
  #@programs = Program.where(:open_suny => 'Open SUNY').uniq
end
def data_science
  render 'data_science', layout: false
end
def education
  render 'education', layout: false
end
def engineering
  render 'engineering', layout: false
end

def general_studies
  render 'general_studies', layout: false
end
def graduate_degrees
  render 'graduate_degrees', layout: false
end
def healthcare
  render 'healthcare', layout: false
end
def psychology
  render 'psychology', layout: false
end
def security_studies
  render 'security_studies', layout: false
end




  private

    def pathway_params
      params.require(:pathway).permit(:title, :headline, :description, :learn_your_way_text, :best_fit_link_1, :best_fit_link_2, :best_fit_link_3, :meta_description, :meta_keywords, :page_title, :pathway_title, :landing_page)
    end
    


    
end

