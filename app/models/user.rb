class User < ApplicationRecord
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false}

  has_secure_password

  has_many :friend_ships, dependent: :destroy
  has_many :friends, :through => :friend_ships, dependent: :destroy
  has_many :inverse_friend_ships, :class_name => 'FriendShip', :foreign_key => 'friend_id', dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friend_ships, :source => :user, dependent: :destroy

  has_many :conversations, :foreign_key => :sender_id

  def incoming_messages
    Message.where(recipient: self)
  end

  def outgoing_messages
    Message.where(sender: self)
  end

  def conversation_list
    Conversation.involving(self)
  end

  def conversation_list_order
    Conversation.involving(self).order("updated_at desc")
  end

  def to_s
    "#{self.name}(#{self.email})"
  end

  def self.from_omniauth(auth)
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    user = where(email: email).first_or_initialize

    user.name = auth[:info][:name] || "User #{Time.now}"
    user.password_digest = "$2a$10$nXweqEUMYG0RrluN0Uiu4uyoqWM3.G2gc6G7btBer0Wtt9smPKXWy"
    user.avatar_url = auth[:info][:image]

    user.save! && user
  end
end
