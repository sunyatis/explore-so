ActiveAdmin.register PointsTransaction do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
   permit_params :school_id, :trans_type, :points, :payment, :attendee, :event_start, :event_end, :course, :approved, :points_type, :trans_date
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
  f.input :points_type,  :as => :select,      :collection => ["CPD", "ITEC"]
  f.input :trans_date, :as => :datepicker
  
  f.submit
  end
end

end
