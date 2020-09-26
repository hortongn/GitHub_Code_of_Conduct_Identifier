json.extract! repository, :id, :login, :name, :url, :stars, :description, :code_of_conduct_id, :created_at, :updated_at
json.url repository_url(repository, format: :json)
