class CatalogsController < ApplicationController

scope :all_published, where(active: true).where(archive: false).order(:name)
  private
  al
    def catalog_params
      params.require(:catalog).permit(:name)
    end
    
    @catalogs = Catalog.all
end

