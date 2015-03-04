ActiveAdmin.register PointsTransaction do
  
#active_admin_import :validate => false,
#                      csv_options: {col_sep: "," },
#                      after_import:  proc{|importer| },
#                      batch_size: 1000,
#                      timestamps: true,
#                      headers_rewrites: {"school_id"=>"school_id", 
#                                            "trans_type"=>"trans_type", 
#                                            "points"=>"points", 
#                                            "payment"=>"payment", 
#                                            "attendee"=>"attendee", 
#                                            "event_start"=>"event_start", 
#                                            "event_end"=>"event_end", 
#                                            "course"=>"course", 
#                                            "approved"=>"approved", 
#                                            "points_type"=>"points_type", 
#                                            "trans_date"=>"trans_date", 
#                                            "approver_comments"=>"approver_comments"} ,
#                      back:  -> {  config.namespace.resource_for(PointsTransaction).route_collection_path }
#
#
  
active_admin_import :validate => true,
            :template_object => ActiveAdminImport::Model.new(
                #:hint => "file will be imported with such header format: 'body','title','author'",
                :csv_headers => ["school_id", "trans_type", "points", "payment", "attendee", "event_start", "event_end", "course", "approved", "points_type", "trans_date", "approver_comments"] 
            )
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :school_id, :trans_type, :points, :payment, :attendee, :event_start, :event_end, :course, :approved, :points_type, :trans_date, :approver_comments
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end
  
  
  form do |f|
    f.inputs "Points Transactions" do
  
  f.input :school_id, :as => :select, :collection => School.pluck(:name, :id)
  f.input :trans_type,  :as => :select,      :collection => ["Credit", "Debit", "Payment"]
  f.input :points
  f.input :payment
  f.input :attendee
  f.input :event_start, :as => :datepicker
  f.input :event_end, :as => :datepicker
  f.input :course
  f.input :approved, :as => :radio, :collection => ["Approved", "Rejected", "Pending"]
  f.input :approver_comments, :as => :text
  f.input :points_type,  :as => :select,      :collection => ["CPD", "ITEC"]
  f.input :trans_date, :as => :datepicker
  
  f.submit
  end
end

end
