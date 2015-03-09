json.array!(@schools) do |school|
  json.extract! school, :id, :name, :address1, :address2, :city, :state, :zip, :school_url, :registration_url, :tuition_url, :financial_aid_url
  json.url school_url(school, format: :json)
end
