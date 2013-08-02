class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.belongs_to :user
      t.string :checkin_id
      t.datetime :checkedin_at
      t.text :blob

      t.timestamps
    end
  end

  def self.down
    drop_table :checkins
  end
end
