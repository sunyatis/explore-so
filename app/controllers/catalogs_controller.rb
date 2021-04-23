class CatalogsController < ApplicationController


  private
  al
    def catalog_params
      params.require(:catalog).permit(:name)
    end
    
    @catalogs = Catalog.all
end

