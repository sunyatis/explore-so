ActiveAdmin.register School do
menu parent: 'Manage Navigator', label: 'School'
  active_admin_import :validate => true,
  :template_object => ActiveAdminImport::Model.new(
  #:hint => "file will be imported with such header format: 'body','title','author'",
  :csv_headers => ["name", "address1", "address2", "city", "state", "zip", "school_url", "registration_url", "tuition_url", "financial_aid_url"] 
  )
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :name, :address1, :address2, :city, :state, :zip, :school_url, :registration_url, :tuition_url, :financial_aid_url, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  show do |school|
    attributes_table do
      row :id
      row :name
      row :address1
      row :address2
      row :city
      row :state
      row :zip
      row :school_url do |school|
         link_to school.school_url, school.school_url
      end
      row :registration_url  do |school|
        link_to school.registration_url, school.registration_url
      end
      row :tuition_url do |school|
        link_to school.tuition_url, school.tuition_url
      end
      row :financial_aid_url do |school|
        link_to school.financial_aid_url, school.financial_aid_url
      end
      row :created_at
      row :updated_at
      row :slug
      row :image do
        image_tag school.image.url(:thumb)
      end
      row :image_file_size
      row :image_content_type
      row :image_updated_at
    end
  end
      
  index do
      id_column
      column :name
      column :city
      column :school_url do |school|
        link_to school.school_url, school.school_url
      end

    actions
  end
  
  
  
 form html: { enctype: "multipart/form-data" } do |f|
   f.inputs "School Details" do
     f.input :name
     f.input :address1
     f.input :address2
     f.input :city
     f.input :state
     f.input :zip
     f.input :school_url 
     f.input :registration_url 
     f.input :tuition_url  
     f.input :financial_aid_url 
     f.input :slug
     f.input :image, as: :file
   end
   f.actions
 end
end
