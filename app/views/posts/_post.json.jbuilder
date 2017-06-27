json.extract! post, :id, :title, :description, :words, :state, :image, :created_at, :updated_at, :tag_list
json.url post_path(post, format: :json)
