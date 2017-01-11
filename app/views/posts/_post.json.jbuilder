json.extract! post, :id, :title, :description, :words, :state, :created_at, :updated_at
json.url post_path(post, format: :json)