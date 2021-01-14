class ContentController < ApplicationController
  def faq
    render 'faq'
  end
  def military
    render 'military'
  end
  def tuition
    render 'tuition-financial-aid'
  end
  def transfer
    render 'transfer'
  end
  
end