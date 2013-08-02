class ApiController < ApplicationController
  
  before_filter :require_user
  
  def index
    # list all the examples
    
  end

  def show
  end

  respond_to :json  
  def pull_4sq
    added = {}
    User.where("token != ''").each do |u|
      num = u.pull_checkins
      added[u.id] = num
    end
    render json: added
  end
  
  respond_to :json, :xml
  def checkins
    #loop to get all users
    #loop to get all checkins
    count = 250
    offset = 0
    array = []
    while count == 250
      checkins = current_user.checkins(:limit => count, :offset => offset)
      array += checkins
      count = checkins.count
      offset += count
    end

    respond_with(array) 
  end
  
end
