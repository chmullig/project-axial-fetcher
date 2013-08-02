class ApiController < ApplicationController
  
  before_filter :require_user
  
  def index
    # list all the examples
    
  end

  def show
  end

  respond_to :json, :html, :xml
  def pull_4sq
    num = 0
    num = User.user_from_token(session['access_token']).pull_checkins
    render json: num
  end
  
  respond_to :json, :xml, :html
  def checkins
    u = User.user_from_token(session['access_token'])
    u.pull_checkins

    render json: u.checkins.map{|c| ActiveSupport::JSON.decode(c.blob)  }
  end
  
end
