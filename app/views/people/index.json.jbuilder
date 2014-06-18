json.array!(@people) do |person|
  json.extract! person, :id, :last_name, :first_name, :email, :summary, :profile_photo
  json.url person_url(person, format: :json)
end
