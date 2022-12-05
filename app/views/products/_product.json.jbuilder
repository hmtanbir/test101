json.extract! product, :id, :url, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
