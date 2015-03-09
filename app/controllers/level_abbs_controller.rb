class LevelAbbsController < ApplicationController
  load_and_authorize_resource
  
  def level_abb_params
    params.require(:level_abb).permit(:name)
  end
  
  
end
