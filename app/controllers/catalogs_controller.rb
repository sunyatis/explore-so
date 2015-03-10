class CatalogsController < ApplicationController

  private

    def catalog_params
      params.require(:catalog).permit(:name)
    end
end

