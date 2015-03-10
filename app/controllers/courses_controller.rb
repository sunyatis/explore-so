class CoursesController < InheritedResources::Base

  private

    def course_params
      params.require(:course).permit(:catalog_id, :title, :code, :description, :credit, :start_date, :end_date, :local_course_id, :prefix, :section, :prerequisites, :corequisites, :books_url, :registration_url, :active, :level, :school_id, :subjectarea_id, :course_area, :general_education, :instructor, :course_method, :seats_available, :class_full)
    end
end

