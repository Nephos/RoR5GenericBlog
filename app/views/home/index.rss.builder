xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title content_for?(:title) ? yield(:title) : ENV["BLOG_TITLE"]
    xml.description content_for?(:description) ? yield(:description) : ENV["BLOG_DESCRIPTION"]
    xml.link posts_url
    for post in @posts
      xml.item do
        xml.title post.title
        xml.image post.image if !post.image.to_s.strip.empty?
        xml.description post.to_short_html
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.lastBuildDate post.updated_at.to_s(:rfc822)
        xml.link read_url(post)
        xml.guid read_url(post)
        xml.comments "#{post.duration}m read"
      end
    end
  end
end