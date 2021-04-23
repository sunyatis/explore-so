class CoursesController < ApplicationController
load_and_authorize_resource

  def index
      @filterrific = initialize_filterrific(
          Course,
          params[:filterrific],
   select_options: {
            sorted_by: Course.options_for_sorted_by,
           with_school_id: Course.options_for_school_select,
           with_catalog_id: Catalog.options_for_select,
           with_generaleducation_id: GeneralEducation.options_for_select,
           with_subject_area_id: SubjectArea.options_for_select,
           with_course_area: Course.options_for_course_area_select,
           with_level: Course.options_for_level_select,
           with_credit: Course.options_for_credit_select,
           with_category: Category.options_for_select
         }#,
  #        persistence_id: 'shared_key',
  #              default_filter_params: {},
  #              available_filters: [],
                    ) or return
                    @courses = @filterrific.find.joins(:catalog).where("courses.catalog_id = catalogs.id and catalogs.active = 't' and courses.active='t'").order("courses.title").page(params[:page])
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

    def update
        course = Course.find(params[:id])
        if course.update(course_params)
          redirect_to courses_path
        else
          render 'edit'
        end
      end

    def my_courses
      #@courses = Course.accessible_by(current_ability, :read)
      @filterrific = initialize_filterrific(
          Course,
          params[:filterrific],
   select_options: {
            sorted_by: Course.options_for_sorted_by,
           with_school_id: Course.options_for_school_select,
           with_catalog_id: Catalog.options_for_select,
           with_generaleducation_id: GeneralEducation.options_for_select,
           with_subject_area_id: SubjectArea.options_for_select,
           with_course_area: Course.options_for_course_area_select,
           with_level: Course.options_for_level_select,
           with_credit: Course.options_for_credit_select,
           with_category: Category.options_for_select
         }#,
  #        persistence_id: 'shared_key',
  #              default_filter_params: {},
  #              available_filters: [],
                    ) or return
                    @courses = @filterrific.find.accessible_by(current_ability, :read).joins(:catalog).where("courses.catalog_id = catalogs.id and catalogs.active = 't' and courses.active='t'").page(params[:page])
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

    def catalogs
      @catalogs = Catalog.where(:active => true)
    end
    def course_areas
       @course_areas = Course.order(:course_area).pluck(:course_area).uniq
    end
    def schools
      @schools = School.all
    end





    def course_params
      params.require(:course).permit(:catalog_id, :title, :code, :description, :credit, :start_date, :end_date, :local_course_id, :prefix, :section, :prerequisites, :corequisites, :books_url, :registration_url, :active, :level, :school_id, :subjectarea_id, :course_area, :generaleducation_id, :instructor, :course_method, :seats_available, :class_full, :cat_id)
    end
  
  
  private

end

