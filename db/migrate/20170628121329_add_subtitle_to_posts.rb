class AddSubtitleToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :subtitle, :string
  end
end
