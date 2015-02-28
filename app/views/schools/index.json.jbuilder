json.array!(@schools) do |school|
  json.extract! school, :id, :name, :address1, :address2, :city, :state, :zip
  json.url school_url(school, format: :json)
end
