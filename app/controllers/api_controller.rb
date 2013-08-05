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

  respond_to :json, :html, :xml
  def pull_4sq_all
    added = {}
    User.where("token != ''").all.each do |u|
      added[u.id] = u.pull_checkins
    end
    
    render json: added
  end
  
  respond_to :json, :xml, :html
  def checkins
    u = User.user_from_token(session['access_token'])
    u.pull_checkins

    render json: u.checkins.map{|c| ActiveSupport::JSON.decode(c.blob)  }
  end

  respond_to :json, :xml, :html
  def geojson
    u = User.user_from_token(session['access_token'])
    checkins = []
    u.checkins.map{|c| ActiveSupport::JSON.decode(c.blob)}.each do |c|
      checkins << {
        'type' => 'Feature',
        'geometry' => {
          'type' => 'Point',
          'coordinates' => [c['venue']['location']['lng'], c['venue']['location']['lat']]
        },
        'properties' => {
          'name' => "#{u.name} at #{c['venue']['name']}",
          'id' => c['id'],
          'timestamp' => c['createdAt'],
          'datetime' => Time.strptime(c['createdAt'].to_s, '%s').to_datetime,
          'user' => u.name,
          'text' => c['shout'] || '',
          'photos' => c['photos']['items'],
          'likes' => c['likes']['count']
         }
      }
    end
    render json: {'type' => 'FeatureCollection', 'features' => checkins}
  end

  respond_to :json, :xml, :html
  def geojson_all
    checkins = []
    User.where("token != ''").each do |u|
      u.checkins.map{|c| ActiveSupport::JSON.decode(c.blob)}.each do |c|
        checkins << {
          'type' => 'Feature',
          'geometry' => {
            'type' => 'Point',
            'coordinates' => [c['venue']['location']['lng'], c['venue']['location']['lat']]
          },
          'properties' => {
            'name' => "#{u.name} at #{c['venue']['name']}",
            'id' => c['id'],
            'timestamp' => c['createdAt'],
            'datetime' => Time.strptime(c['createdAt'].to_s, '%s').to_datetime,
            'venue' => c['venue']['name'],
            'user' => u.name,
            'text' => c['shout'] || '',
            'photos' => c['photos']['items'],
            'likes' => c['likes']['count']
           }
        }
      end
    end

    render json: {'type' => 'FeatureCollection', 'features' => checkins}
  end
  
end
