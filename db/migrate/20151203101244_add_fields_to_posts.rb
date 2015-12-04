class AddFieldsToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :description
    add_column :posts, :image_url, :text
    add_column :posts, :video_url, :text
    add_column :posts, :likes, :integer
    add_column :posts, :comments_count, :integer
    add_column :posts, :caption_text, :text
    add_column :posts, :tag_name, :string
    add_column :posts, :tag_type, :string
    add_column :posts, :profile_picture, :string
    add_column :posts, :full_name, :string
    add_reference :posts, :user, index: true
  end
end
