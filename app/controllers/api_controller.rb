class ApiController < ApplicationController
  
  before_filter :require_user
  
  def index
    # list all the examples
    
  end
  
  respond_to :json, :xml
  def checkins
    #loop to get all
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
