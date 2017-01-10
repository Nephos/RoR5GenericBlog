# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

get_post = (id, callback) ->
  $.get "/read/#{id}.json", (data, success, _) ->
    callback(data)

update_post = (id, title, description, callback) ->
  $.ajax type: "PATCH", url: "/update/#{id}.json", data: {post: {title: title, description: description}}, success: (data, status, _)->
    callback(data)

$ ->
  document.edition = false
  $(document).on "click", ".post-edit", (e) ->
    e.preventDefault()
    id = $(".post-id").attr("id")
    if document.edition == false
      get_post id, (data_post) ->
        $(".post-title").html('<input class="form-control" value=""></input>')
        $(".post-title input").val(data_post.title)
        $(".post-description").html('<textarea class="form-control"></textarea>')
        $(".post-description textarea").val(data_post.description)
        document.edition = true
    else
      title = $(".post-title input").val()
      description = $(".post-description textarea").val()
      update_post id, title, description, (data_post) ->
        $(".post-title").html("<h1>" + data_post.title + "</h1>")
        $(".post-description").html("<div>" + data_post.to_html + "</div>")
        document.edition = false
