Apipie.configure do |config|
  config.app_name                = "Blog"
  config.api_base_url            = ""
  config.doc_base_url            = "/doc"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
