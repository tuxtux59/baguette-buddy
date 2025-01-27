json.extract! receipe, :id, :title, :description, :user_id, :portions_number, :created_at, :updated_at
json.url receipe_url(receipe, format: :json)
json.image receipe.base64_content
json.image_type receipe.image_type
