module HomeHelper
  def tag_list_links(post)
    post.tag_list.map do |tag|
      link_to tag, root_path(tag: tag), class: "label"
    end.join(" ").html_safe
  end
end
