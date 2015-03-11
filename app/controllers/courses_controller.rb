class CoursesController < ApplicationController


  def index
      @filterrific = initialize_filterrific(
          Course,
          params[:filterrific],
   select_options: {
            sorted_by: Course.options_for_sorted_by,
           with_school_id: School.options_for_select,
           with_catalog_id: Catalog.options_for_select,
           with_general_education: GeneralEducation.options_for_select
         }#,
  #        persistence_id: 'shared_key',
  #              default_filter_params: {},
  #              available_filters: [],
                    ) or return
                    @courses = @filterrific.find.page(params[:page])
                        # Respond to html for initial page load and to js for AJAX filter updates.
                        respond_to do |format|
                          format.html
                          format.js
                        end

                      # Recover from invalid param sets, e.g., when a filter refers to the
                      # database id of a record that doesn’t exist any more.
                      # In this case we reset filterrific and discard all filter params.
                    #  rescue ActiveRecord::RecordNotFound => e
                        # There is an issue with the persisted param_set. Reset it.
                    #    puts "Had to reset filterrific params: #{ e.message }"
                     #   redirect_to(reset_filterrific_url(format: :html)) and return  
    end



    def my_courses
      @courses = Course.accessible_by(current_ability, :read)
    end






  private

    def course_params
      params.require(:course).permit(:catalog_id, :title, :code, :description, :credit, :start_date, :end_date, :local_course_id, :prefix, :section, :prerequisites, :corequisites, :books_url, :registration_url, :active, :level, :school_id, :subjectarea_id, :course_area, :general_education, :instructor, :course_method, :seats_available, :class_full)
    end
end

