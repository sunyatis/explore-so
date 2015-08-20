class SchoolsController < ApplicationController
load_and_authorize_resource

def show
   @schools = School.order(:name)
 end


def show
   @schools = School.find(params[:id])
end



  #private

    def school_params
      params.require(:school).permit(:name, :address1, :address2, :city, :state, :zip, :school_url, :registration_url, :tuition_url, :financial_aid_url)
    end
end

