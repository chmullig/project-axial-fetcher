class SessionsController < ApplicationController

  def new
    user = User.find_or_create_by_token(@access_token)
    user.token = @access_token
    user.save!

    return redirect_to examples_path if current_user
    @authorize_url = foursquare.authorize_url(callback_session_url)
  end
  
  def callback
    code = params[:code]
    @access_token = foursquare.access_token(code, callback_session_url)
    session[:access_token] = @access_token

    Rails.logger.debug @access_token

    user = User.find_or_create_by_token(@access_token)
    user.token = @access_token
    user.save!

    redirect_to examples_path
  end
  
end