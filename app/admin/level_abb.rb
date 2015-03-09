ActiveAdmin.register LevelAbb do
  active_admin_import :validate => true,
  :template_object => ActiveAdminImport::Model.new(
  #:hint => "file will be imported with such header format: 'body','title','author'",
  :csv_headers => ["name", "description"] 
  )

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :description
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end


end
