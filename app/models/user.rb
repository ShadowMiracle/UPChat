class User < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false}

  has_secure_password

  has_many :friend_ships, dependent: :destroy
  has_many :friends, :through => :friend_ships, dependent: :destroy
  has_many :inverse_friend_ships, :class_name => 'FriendShip', :foreign_key => 'friend_id', dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friend_ships, :source => :user, dependent: :destroy

  def incoming_messages
    Message.where(recipient: self)
  end

  def outgoing_messages
    Message.where(sender: self)
  end

  def to_s
    "#{self.name}(#{self.email})"
  end
end
