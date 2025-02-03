json.extract! ingredient, :receipe_id, :product_item_id, :quantity
json.receipe do
  json.extract! ingredient.receipe, :id, :title
end

json.product_item do
  json.extract! ingredient.product_item, :id, :name
  json.unit ingredient.product_item.unit.name
end
# json.resource do
#   json.partial! ingredient.receipe, as: :receipe
# end

# json.product_item do
#   json.partial! ingredient.product_item, as: :product_item
# end
json.url api_ingredient_url(ingredient, format: :json)
json.extract! ingredient, :created_at, :updated_at
