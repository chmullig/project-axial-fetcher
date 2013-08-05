class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.belongs_to :user
      t.timestamp :tweeted_at
      t.text :blob
      t.timestamp :timestamps

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
