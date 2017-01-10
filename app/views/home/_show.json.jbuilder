json.extract! post, :id, :title, :to_html, :to_short_html, :words, :date, :created_at, :updated_at
json.url post_url(post, format: :json)
