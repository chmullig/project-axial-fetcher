class AddNameAndTwitterToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :twitter, :string
    User.where("token != ''").all.each do |u|
      u.name = u.fsq_user.name
      u.save!
    end
  end

  def self.down
  end
end
