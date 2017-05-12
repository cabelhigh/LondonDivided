json.extract! item, :id, :name, :description, :item_type, :value, :created_at, :updated_at
json.url item_url(item, format: :json)
