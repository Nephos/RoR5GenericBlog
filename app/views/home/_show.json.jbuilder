json.extract! post, :id, :title, :description, :to_html, :to_short_html, :words, :date, :created_at, :updated_at
json.url post_path(post, format: :json)
