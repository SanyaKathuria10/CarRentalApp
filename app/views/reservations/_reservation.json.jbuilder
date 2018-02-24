json.extract! reservation, :id, :rid, :checkout_time, :return_time, :location, :total_bill, :reservation_status, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
