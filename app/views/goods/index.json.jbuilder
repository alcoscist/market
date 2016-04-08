json.array!(@goods) do |good|
  json.extract! good, :id, :title, :description, :image_url, :price
  json.url good_url(good, format: :json)
end
