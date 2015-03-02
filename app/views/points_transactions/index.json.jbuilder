

json.array!(@pending) do |pending|
  json.extract! pending, :id, :school_id, :trans_type, :points, :payment, :attendee, :event_start, :event_end, :course, :approved, :points_type, :trans_date
  json.url points_transaction_url(pending, format: :json)
end

json.array!(@points_transactions) do |points_transaction|
  json.extract! points_transaction, :id, :school_id, :trans_type, :points, :payment, :attendee, :event_start, :event_end, :course, :approved, :points_type, :trans_date
  json.url points_transaction_url(points_transaction, format: :json)
end
