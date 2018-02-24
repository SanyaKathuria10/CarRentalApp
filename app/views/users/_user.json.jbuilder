json.extract! user, :id, :uid, :name, :email, :password, :phone_number, :currently_reserved, :created_at, :updated_at
json.url user_url(user, format: :json)
