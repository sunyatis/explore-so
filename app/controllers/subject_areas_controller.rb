class SubjectAreasController < ApplicationController
  load_and_authorize_resource
  
  def subject_area_params
    params.require(:subject_area).permit(:name)
  end
  
end
