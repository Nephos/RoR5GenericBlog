= form_for @post, :html => { :class => "form-horizontal post" } do |f|
  - if @post.errors.any?
    #error_expl.panel.panel-danger
      .panel-heading
        h3.panel-title
          = pluralize(@post.errors.count, "error")
          |  prohibited this post from being saved:
      .panel-body
        ul
          - @post.errors.full_messages.each do |msg|
            li
              = msg
  .form-group
    = f.label :title, :class => 'control-label col-lg-2'
    .col-lg-10
      = f.text_field :title, :class => 'form-control'
    =f.error_span(:title)
  .form-group
    = f.label :description, :class => 'control-label col-lg-2'
    .col-lg-10
      = f.text_field :description, :class => 'form-control'
    =f.error_span(:description)
  .form-group
    = f.label :state, :class => 'control-label col-lg-2'
    .col-lg-10
      = f.text_field :state, :class => 'form-control'
    =f.error_span(:state)
  .form-group
    .col-lg-offset-2.col-lg-10
      = f.submit nil, :class => 'btn btn-primary'
      = link_to t('.cancel', :default => t("helpers.links.cancel")),
      -                 posts_path, :class => 'btn btn-default'
