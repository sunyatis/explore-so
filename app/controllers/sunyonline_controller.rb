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
      if (params.has_key?(:page4))
        render template: "sunyonline/#{params[:page4]}/#{params[:page3]}/#{params[:page2]}/#{params[:page1]}/#{params[:page]}"
    elsif (!params.has_key?(:page4)) && (params.has_key?(:page3))
        puts "sunyonline/#{params[:page3]}"
            render template: "sunyonline/#{params[:page3]}/#{params[:page2]}/#{params[:page1]}/#{params[:page]}"
         elsif (!params.has_key?(:page3)) && (params.has_key?(:page2))
             puts "sunyonline/#{params[:page2]}"
                 render template: "sunyonline/#{params[:page2]}/#{params[:page1]}/#{params[:page]}"
              elsif (!params.has_key?(:page2)) && (params.has_key?(:page1))
        puts "sunyonline/#{params[:page1]}"
            render template: "sunyonline/#{params[:page1]}/#{params[:page]}"
         else
            
          end
          
              
              
            
                
      
       # render template: "sunyonline/#{params[:page]}"
    end
  
  
end