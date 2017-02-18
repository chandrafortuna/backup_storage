json.extract! profile_log, :id, :title, :path, :created_at, :updated_at
json.url profile_log_url(profile_log, format: :json)