class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:instagram]

  has_one :social_media
  has_many :posts

# def self.from_instagram_omniauth(auth, _signed_in_resource = nil)
#   identity = SocialMedia.find_or_initialize_by(uid: auth.uid, provider: auth.provider)
#   binding.pry
#   if identity.new_record?
#     user = User.find_or_initialize_by(email: auth.email)
#     #user.first_name = auth.info.name
#     user.password = Devise.friendly_token[0, 20]
#     user.save
#     identity.token = auth.credentials.token
#     identity.user = user
#     binding.pry
#   # identity.image_url = auth.info.image
#   identity.save
#   identity.user
#   else
#     binding.pry
#     identity.user
#   end
# end

  def connect_with_instagram(auth)
    identity = social_media || build_social_media
  # identity = SocialMedia.find_or_initialize_by(uid: auth.uid)
    identity.uid = auth.uid
    identity.token = auth.credentials.token
  # identity.image_url = auth.info.image
    identity.save
    self
  end
end
