class Message < ApplicationRecord
  validates :body, presence: true

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'

  belongs_to :conversation

  scope :unread, -> {
    where(read_at: nil)
  }

  default_scope {
    order('created_at ASC')
  }

  def mark_as_read!
    self.read_at = Time.now
    save!
  end

  def read?
    read_at
  end
end
