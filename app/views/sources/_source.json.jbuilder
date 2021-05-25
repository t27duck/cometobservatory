json.extract! source, :id, :name, :url, :image_filename, :source_class, :created_at, :updated_at
json.url source_url(source, format: :json)
