# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

get_post = (id, callback) ->
  $.get "/read/#{id}.json", (data, success, _) ->
    callback(data)

update_post = (id, title, description, tags, callback) ->
  $.ajax type: "PATCH", url: "/update/#{id}", data: {short: $(".post-edit-long")[0] == undefined, post: {title: title, description: description, tag_list: tags}}, success: (data, status, _)->
    callback(data)

enable_edition_mode = ->
  document.edition = false
  $(document).on "click", ".post-edit", (e) ->
    e.preventDefault()
    post = $(this).parent().parent().parent()
    id = $(".post-id", post).attr("id")
    if document.edition == false
      get_post id, (data_post) ->
        $(".post-title", post).html('<input class="form-control" value=""></input>')
        $(".post-title input", post).val(data_post.title)
        $(".post-tags", post).html('<input class="form-control" value=""></input>')
        $(".post-tags input", post).val(data_post.tag_list)
        $(".post-description", post).html('<textarea id=textarea class="form-control textarea_resize"></textarea>')
        $(".post-description textarea", post).val(data_post.description)
        textarea_resize("textarea.textarea_resize", post)
        document.edition = true
    else
      title = $(".post-title input", post).val()
      description = $(".post-description textarea", post).val()
      tag_list = $(".post-tags input", post).val()
      update_post id, title, description, tag_list, (data_post) ->
        post.replaceWith(data_post)
        document.edition = false

$ ->
  document.addEventListener "turbolinks:load", ->
    enable_edition_mode()
  enable_edition_mode()
