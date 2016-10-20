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

  def self.from_omniauth(auth)
    puts auth
    # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
    # and figure out how to get email for this user.
    # Note that Facebook sometimes does not return email,
    # in that case you can use facebook-id@facebook.com as a workaround

    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    user = where(email: email).first_or_initialize

    # Set other properties on user here. Just generate a random password. User does not have to use it.
    # You may want to call user.save! to figure out why user can't save
    #
    # Finally, return user
    user.name = auth[:info][:name] || "User #{Time.now}"
    user.password_digest = "$2a$10$nXweqEUMYG0RrluN0Uiu4uyoqWM3.G2gc6G7btBer0Wtt9smPKXWy"
    user.avatar_url = auth[:info][:image]

    user.save! && user
  end
end
