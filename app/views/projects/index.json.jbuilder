json.array!(@projects) do |project|
  json.extract! project, :id, :title, :summary
  json.url project_url(project, format: :json)
end
