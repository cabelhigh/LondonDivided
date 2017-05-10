json.extract! item, :id, :name, :description, :type, :value, :created_at, :updated_at
json.url item_url(item, format: :json)
