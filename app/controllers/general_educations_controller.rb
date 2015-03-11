class GeneralEducationsController < InheritedResources::Base

  private

    def general_education_params
      params.require(:general_education).permit(:name)
    end
end

