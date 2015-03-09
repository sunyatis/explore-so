json.array!(@programs) do |program|
  json.extract! program, :id, :prog_title, :description, :subject_area, :prog_level, :level_abb, :school_id, :duration, :delivery_method, :prerequisites, :program_url, :registration_url, :open_suny, :per_courses_online, :synchronous, :synchronous_text, :tutoring, :tutoring_name, :tutoring_phone, :tutoring_email, :tutoring_url, :helpdesk, :helpdesk_phone, :helpdesk_email, :helpdesk_url, :concierge, :concierge_phone, :concierge_name, :concierge_email, :experiential_learning, :experiential_text, :plas, :plas_text, :accelerated, :accelerated_text, :summary, :level_expanded, :sed, :apply_now_url
  json.url program_url(program, format: :json)
end
