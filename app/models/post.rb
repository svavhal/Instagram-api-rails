class Post < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user

  def self.save_tag(tag_id, text, image_url, screen_name)
    post = Post.new
    post.tag_id = tag_id
    post.description = text
    post.profile_image_url = image_url
    post.uname = screen_name
    post.save
  end

end
