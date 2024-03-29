module ApplicationHelper
  
  def title(page_title)
    content_for(:title) {page_title}
  end
  
  def meta_key(keywords)
    content_for(:meta_key) {keywords}
  end
  
  def meta_desc(description)
    content_for(:meta_desc) {description}
  end
  
  def yield_or_default(section, default = "")
      content_for?(section) ? content_for(section) : default
  end
end
