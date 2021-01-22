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
          when :page1
            render template: "sunyonline/#{params[:page1]}/#{params[:page]}"
         else
            'degree-programs'
          end
      
       # render template: "sunyonline/#{params[:page]}"
    end
  
  
end