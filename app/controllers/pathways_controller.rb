class PathwaysController < ApplicationController


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

  private

    def pathway_params
      params.require(:pathway).permit(:name)
    end
    
    @pathways = Pathway.all
    
    
    
end

