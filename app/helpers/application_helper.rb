module ApplicationHelper
  
  
  def yield_or_default(section, default = "")
       content_for?(section) ? content_for(section) : default
   end
  
    def title(page_title)
      content_for(:title) {page_title}
    end
    
    def description(page_meta)
      content_for(:description) {page_meta}
    end
  
  
end
