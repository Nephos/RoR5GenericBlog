# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

get_post = (id, callback) ->
  $.get "/read/#{id}.json", (data, success, _) ->
    callback(data)

update_post = (id, title, description, tags, callback) ->
  $.ajax type: "PATCH", url: "/update/#{id}.json", data: {post: {title: title, description: description, tag_list: tags}}, success: (data, status, _)->
    callback(data)

enable_edition_mode = ->
  document.edition = false
  $(document).on "click", ".post-edit", (e) ->
    e.preventDefault()
    id = $(".post-id").attr("id")
    if document.edition == false
      get_post id, (data_post) ->
        $(".post-title").html('<input class="form-control" value=""></input>')
        $(".post-title input").val(data_post.title)
        $(".post-tags").html('<input class="form-control" value=""></input>')
        $(".post-tags input").val(data_post.tag_list)
        $(".post-description").html('<textarea id=textarea class="form-control"></textarea>')
        $(".post-description textarea").val(data_post.description)
        $('.post-description textarea').keydown (ev) -> textarea_resize(ev.target)
        textarea_resize($('.post-description textarea')[0])
        document.edition = true
    else
      title = $(".post-title input").val()
      description = $(".post-description textarea").val()
      tag_list = $(".post-tags input").val()
      update_post id, title, description, tag_list, (data_post) ->
        $(".post-title").html("<h1>" + data_post.title + "</h1>")
        $(".post-description").html("<div>" + data_post.to_html + "</div>")
        build_tag_html = (tag) ->
          "<a class=\"label label-default\" href=\"/?tag=#{tag}\">#{tag}</a>"
        $(".post-tags").html(data_post.tags.map((t) -> build_tag_html(t)).join(" "))
        document.edition = false

textarea_resize = (el) ->
  $('textarea').each( ->
    this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;')
  ).on('input', ->
    this.style.height = 'auto'
    this.style.height = (this.scrollHeight) + 'px'
  )

$ ->
  enable_edition_mode()
