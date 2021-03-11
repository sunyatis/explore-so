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
  def index
    @schools = School.joins(:programs).where("programs.school_id = schools.id and programs.open_suny = 'Open SUNY'").uniq
    @programs = Program.where(:open_suny => 'Open SUNY').uniq
  end
end