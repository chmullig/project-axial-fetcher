class Tweet < ActiveRecord::Base
  def twitter_client
    @twitter_client ||= Twitter::Client.new(consumer_key: Settings.twitter_consumer_key, consumer_secret: Settings.twitter_consumer_secret, oauth_token: Settings.twitter_access_key, oauth_token_secret: Settings.twitter_access_secret)
  end

  def get_timeline(user)
    @twitter_client.user_timeline(user, count: 200)
  end
end
