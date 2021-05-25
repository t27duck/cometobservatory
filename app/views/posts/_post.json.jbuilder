json.extract! post, :id, :source_id, :title, :url, :uid, :published_at, :created_at, :updated_at
json.url post_url(post, format: :json)
