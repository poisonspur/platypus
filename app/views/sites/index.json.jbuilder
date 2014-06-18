json.array!(@sites) do |site|
  json.extract! site, :id, :base_name, :disp_name, :is_home_ssl, :admin_email, :welcome, :about
  json.url site_url(site, format: :json)
end
