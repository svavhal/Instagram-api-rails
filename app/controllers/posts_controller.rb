require 'rest-client'
class PostsController < ApplicationController
  def index
    if current_user.social_media.present?
      insta_token = current_user.social_media.token
      @insta_client = Instagram.client(access_token: insta_token)
      @user_posts = RestClient.get("https://api.instagram.com/v1/users/self/feed?access_token=#{insta_token}")
      @posts = JSON.parse(@user_posts) rescue ''
      @latest_posts = @posts['data'].sort_by { |x| x['created_time'] }.reverse rescue ''

      # Getting Instagram User Info and save to DB

      @user = RestClient.get("https://api.instagram.com/v1/users/self/?access_token=#{insta_token}")
      @user_info = JSON.parse(@user)
      username = @user_info['data']['username'] rescue ''
      bio = @user_info['data']['bio'] rescue ''
      website = @user_info['data']['website'] rescue ''
      profile_picture = @user_info['data']['profile_picture'] rescue ''
      full_name = @user_info['data']['full_name'] rescue ''
      followed_by = @user_info['counts']['followed_by'] rescue ''
      follows = @user_info['data']['follows'] rescue ''
      user_id = current_user.id
      @user = User.find_or_initialize_by(id: current_user.id)
      user_params = { username: username, bio: bio, website: website, profile_picture: profile_picture, full_name: full_name, followed_by: followed_by, follows: follows, id: user_id }
      @user.assign_attributes(user_params)
      @user.save

     # Getting Instagram User latest 10 Posts Info and save to DB

      @latest_posts[1..10].each do |post|
        img_url = post['images']['standard_resolution']['url'] rescue ''
        video_url = post['videos']['standard_resolution']['url'] rescue ''
        user_name = post['user']['username'] rescue ''
        profile_pic = post['user']['profile_picture'] rescue ''
        full_name = post['user']['full_name'] rescue ''
        likes_cnt = post['likes']['count'] rescue ''
        comments_cnt = post['comments']['count'] rescue ''
        user_id = current_user.id rescue ''
        text = post['caption']['text'] rescue ''
        tags = post['tags'][] rescue ''
        type = post['type'] rescue ''
        @post = Post.find_or_initialize_by(user_id: user_id, image_url: img_url, caption_text: text)

        params = { image_url: img_url, user_name: user_name, image_url: img_url, video_url: video_url, likes: likes_cnt, comments_count: comments_cnt, caption_text: text, tag_name: tags, tag_type: type, profile_picture: profile_pic , full_name: full_name, user_id: user_id }
        @post.assign_attributes(params)
        @post.save
      end
    end
  end

  def dashboard
  end

  private

  def posts_params
    params.require(:post).permit(:profile_image_url, :user_name, :tag_id, :image_url, :video_url, :likes, :comments_count, :caption_text, :tag_name, :tag_type, :profile_picture, :full_name, :user_id)
  end
end
