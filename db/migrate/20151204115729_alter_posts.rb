class AlterPosts < ActiveRecord::Migration
  def change
    add_column :posts, :profile_image_url, :string
    add_column :posts, :uname, :string
    add_column :posts, :description, :text
  end
end
