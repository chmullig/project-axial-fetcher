class Tweet < ActiveRecord::Base
  Usernames = %w(rubinovitz seagaia2 chimeracoder zencephalon linstantnoodles chmullig
  thetabyte t3hprogrammer basilksiddiqui borowskidaniel drjid sclarawu jbcima a2 djj2115
  dskang celehner exchgr kyle_petrovich jmatth92 katieposkaitis elbuo8 jfriedhoff dotgil
  hackny ) #sanapants

  def self.twitter_client
    @twitter_client ||= Twitter::Client.new(consumer_key: Settings.twitter_consumer_key, consumer_secret: Settings.twitter_consumer_secret, oauth_token: Settings.twitter_access_key, oauth_token_secret: Settings.twitter_access_secret)
  end

  def get_timeline(user)
    @twitter_client.user_timeline(user, count: 200)
  end


end
