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
      case params[:page1]
          when 'contact'
            render template: "sunyonline/contact/#{params[:page]}"
         else
            'application'
          end
      
        render template: "sunyonline/#{params[:page]}"
    end
  
  
end