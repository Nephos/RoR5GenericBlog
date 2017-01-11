YAML.parse_file("blog.yml").to_ruby.each do |key, value|
  ENV["BLOG_#{key.upcase}"] = value
end
