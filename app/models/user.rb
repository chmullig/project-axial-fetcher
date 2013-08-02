class User < ActiveRecord::Base
  has_many :checkins

  def fsq_user 
    @fsq_user ||= Foursquare::Base.new(token).users.find("self")
  end

  def self.user_from_token(access_token)
    User.find_or_create_by_token(access_token)
  end

  def self.user_from_current_user
    User.find_or_create_by_token(current_user.access_token)
  end

  def pull_checkins
    count = 250
    offset = 0
    last_pulled = checkins.order(:checkedin_at).last.try(:checkedin_at) || '1370059200'
    Rails.logger.debug "Last pulled is: #{last_pulled}"

    while count == 250
      newcheckins = fsq_user.checkins(limit: count, offset: offset, afterTimestamp: last_pulled )
      newcheckins.each do |c|
        Checkin.find_or_create_by_checkin_id(user_id: id, checkin_id: c.id, checkedin_at: c.json['createdAt'], blob: c.json.to_json)
      end
      count = newcheckins.count
      offset += count
    end
    offset
  end
end
