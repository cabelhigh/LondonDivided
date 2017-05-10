json.extract! quest, :id, :quest_name, :description, :day, :quest_type, :money_output, :info_output, :item_output, :dependent_on, :unlocks, :created_at, :updated_at
json.url quest_url(quest, format: :json)
