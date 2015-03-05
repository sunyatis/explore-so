class SchoolsController < InheritedResources::Base

  load_and_authorize_resource
  
  private

    def school_params
      params.require(:school).permit(:name, :address1, :address2, :city, :state, :zip)
    end
    
  
end

