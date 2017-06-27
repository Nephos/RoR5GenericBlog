json.extract! post, :id, :title, :description, :to_html, :to_short_html, :words, :duration, :date, :image, :created_at, :updated_at
json.tag_list post.tag_list.join(", ")
json.tags post.tags.pluck :name
json.url post_path(post, format: :json)
