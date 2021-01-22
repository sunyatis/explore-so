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
      if (params.has_key?(:page3))
        puts "#{params[:page3]}"
            render template: "sunyonline/#{params[:page3]}/#{params[:page2]}/#{params[:page1]}/#{params[:page]}"
         else
             end
           
           if (params.has_key?(:page2))
             puts "#{params[:page2]}"
                 render template: "sunyonline/#{params[:page2]}/#{params[:page1]}/#{params[:page]}"
              else
            
               end
      if (params.has_key?(:page1))
        puts "#{params[:page1]}"
            render template: "sunyonline/#{params[:page1]}/#{params[:page]}"
         else
            
          end
          
              
              
            
                
      
       # render template: "sunyonline/#{params[:page]}"
    end
  
  
end