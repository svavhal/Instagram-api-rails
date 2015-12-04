class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def instagram
    @user = current_user.connect_with_instagram(request.env['omniauth.auth'])
    flash_and_redirect_user
  end

  def flash_and_redirect_user
    if current_user
      flash[:success] = 'Successfully connected with instagram'
      redirect_to root_path
    else
      set_flash_message(:notice, :success, kind: 'Instagram') if is_navigational_format?
      redirect_to tags_path event: :authentication
    end
  end
end
