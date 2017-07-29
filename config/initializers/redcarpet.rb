
require 'rouge/plugins/redcarpet'

class RougeRender < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

MARKDOWN = Redcarpet::Markdown.new RougeRender,
  autolink: true,
  tables: true,
  strikethrough: true,
  underline: true,
  highlight: true,
  quote: true,
  footnotes: true,
  fenced_code_blocks: true
