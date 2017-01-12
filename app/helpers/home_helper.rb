module HomeHelper
  def tag_list_links(post)
    post.tag_list.map do |tag|
      link_to tag, root_path(tag: tag), class: "label label-default"
    end.join(" ").html_safe
  end
end
