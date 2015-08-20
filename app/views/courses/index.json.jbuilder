json.array!(@courses) do |course|
  json.extract! course, :id, :catalog_id, :title, :code, :description, :credit, :start_date, :end_date, :local_course_id, :prefix, :section, :prerequisites, :corequisites, :books_url, :registration_url, :active, :level, :school_id, :subjectarea_id, :course_area, :general_education, :instructor, :course_method, :seats_available, :class_full, :cat_id
  json.url course_url(course, format: :json)
end
