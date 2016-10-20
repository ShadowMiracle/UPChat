class Message < ApplicationRecord
  validates :body, presence: true

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  scope :unread, -> {
    where(read_at: nil)
  }

  scope :between, -> (sender_id, recipient_id) {
    where("(sender_id = ? AND recipient_id = ?)
        OR (sender_id = ? AND recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
  }

  scope :involving, -> (user_id) {
    where("sender_id = ? OR recipient_id = ?", user_id, user_id)
  }

  default_scope {
    order('created_at DESC')
  }

  def mark_as_read!
    self.read_at = Time.now
    save!
  end

  def read?
    read_at
  end
end
