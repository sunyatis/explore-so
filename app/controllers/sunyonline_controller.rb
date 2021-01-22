class SunyonlineController < ApplicationController
  #def index
   # render 'index', layout: false
  #end
  include HighVoltage::StaticPage

   layout :false

    #private

#   def layout_for_page
#     case params[:id]
#     when 'media'
#       'media'
#     else
#       'application'
#     end
#   end
  
    def show
      if (params.has_key?(:page1))
            render template: "sunyonline/#{params[:page1]}/#{params[:page]}"
         else
            
          end
      
       # render template: "sunyonline/#{params[:page]}"
    end
  
  
end