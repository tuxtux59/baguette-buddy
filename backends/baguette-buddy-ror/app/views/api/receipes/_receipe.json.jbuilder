json.extract! receipe, :id, :title, :description, :user_id, :portions_number, :created_at, :updated_at
json.ingredients receipe.ingredients do |ingredient|
  json.title ingredient.product_item.name
  json.unit do
    json.extract! ingredient.product_item.unit, :name, :plural, :abbreviation
  end
  json.quantity ingredient.quantity
end
json.url receipe_url(receipe, format: :json)
json.image receipe.base64_content
json.image_type receipe.image_type
