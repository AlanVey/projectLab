json.array!(@etherpads) do |etherpad|
  json.extract! etherpad, :id, :name, :file, :creator
  json.url etherpad_url(etherpad, format: :json)
end
