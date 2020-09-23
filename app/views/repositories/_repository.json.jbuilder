json.extract! repository, :id, :login, :name, :url, :stars, :description, :created_at, :updated_at
json.url repository_url(repository, format: :json)
