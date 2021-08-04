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
  render 'business', layout: false
  #@programs = Program.where(:open_suny => 'Open SUNY').uniq
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
      params.require(:pathway).permit(:name)
    end
    
    @pathways = Pathway.all
    
    
    
end

