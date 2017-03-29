json.current_page_number @page
json.current_page home_url(format: :json, page: @page)
json.next_page home_url(format: :json, page: @page+1)
json.prev_page home_url(format: :json, page: @page-1) if @page > 1
json.posts do
  json.array!(@posts, partial: 'home/show', as: :post)
end
