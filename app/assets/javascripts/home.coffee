# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

get_post = (id, callback) ->
  $.get "/read/#{id}.json", (data, success, _) ->
    callback(data)

update_post = (id, title, subtitle, description, tags, image, callback) ->
  $.ajax type: "PATCH", url: "/update/#{id}", data: {
        short: $(".post-edit-long")[0] == undefined,
        post: {title: title, subtitle: subtitle, description: description, tag_list: tags, image: image}
    }, success: (data, status, _)->
    callback(data)

enable_edition_mode = ->
  document.edition = false
  $(document).on "click", ".post-edit", (e) ->
    e.preventDefault()
    post = $(this).parent().parent().parent()
    id = $(".post-id", post).attr("id")
    if document.edition == false
      get_post id, (data_post) ->
        $(".post-title", post).html('title: <input class="form-control" value=""></input>')
        $(".post-title input", post).val(data_post.title)
        $(".post-subtitle", post).html('subtitle: <input class="form-control" value=""></input>')
        $(".post-subtitle input", post).val(data_post.subtitle)
        $(".post-tags", post).html('tags: <input class="form-control" value=""></input>')
        $(".post-tags input", post).val(data_post.tag_list)
        $(".post-img", post).html('img: <input class="form-control" value=""></input>')
        $(".post-img input", post).val(data_post.image)
        $(".post-description", post).html('<textarea id=textarea class="form-control textarea_resize"></textarea>')
        $(".post-description textarea", post).val(data_post.description)
        textarea_resize("textarea.textarea_resize", post)
        document.edition = true
    else
      title = $(".post-title input", post).val()
      subtitle = $(".post-subtitle input", post).val()
      description = $(".post-description textarea", post).val()
      tag_list = $(".post-tags input", post).val()
      image = $(".post-img input", post).val()
      update_post id, title, subtitle, description, tag_list, image, (data_post) ->
        post.replaceWith(data_post)
        document.edition = false
        enable_image()

enable_image = ->
  $(".post-img img").each (_, img) ->
    if img.src == window.location.origin + "/"
      $(img).hide()
    else
      $(img).show()

$ ->
  document.addEventListener "turbolinks:load", ->
    enable_edition_mode()
    enable_image()
  enable_edition_mode()
