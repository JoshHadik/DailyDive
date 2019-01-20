json.extract! response, :id, :question, :body, :entry_id, :created_at, :updated_at
json.url response_url(response, format: :json)
