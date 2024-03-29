class SchoolsController < ApplicationController
load_and_authorize_resource

def show
   @schools = School.order(:name)
 end


def show
   @schools = School.find(params[:id])
end

def index
  @schools = School.order(:name)
end




  #private

    def school_params
      params.require(:school).permit(:name, :address1, :address2, :city, :state, :zip, :school_url, :registration_url, :tuition_url, :financial_aid_url, :campus_type, :registrar_phone, :abbv, :course_registration_url, :bookstore_url, :grad_course_reg_url)
    end
end

