class AddFieldsToUsers < ActiveRecord::Migration
  def change
    remove_column :posts, :profile_image_url
    add_column :users, :username, :string
    add_column :users, :bio, :string
    add_column :users, :website, :string
    add_column :users, :profile_picture, :string
    add_column :users, :full_name, :string
    add_column :users, :followed_by, :integer
    add_column :users, :follows, :integer
  end
end
