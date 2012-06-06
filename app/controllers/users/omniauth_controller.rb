class Users::OmniauthController < Devise::OmniauthCallbacksController
  def twitter
    #render request.env["omniauth.auth"].to_yaml and return
    connect('twitter')
  end

  def vkontakte
    connect('vkontakte')
  end

  def facebook
    connect('facebook')
  end

  def google_oauth2
    connect('google_oauth2')
  end

  def github
    connect('github')
  end



  protected

  def connect(provider)
    #render request.env["omniauth.auth"].extra.raw_info.to_yaml and return
    user = Social.find_for(provider, request.env["omniauth.auth"], current_user)
    if user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => provider.titleize
      if user_signed_in?
        redirect_to user_path(user)
      else
        sign_in_and_redirect user, :event => :authentication
      end
    else
      session["devise.provider_data"] = request.env["omniauth.auth"]
      session["devise.provider_name"] = provider
      redirect_to new_user_registration_url
    end
  end
end