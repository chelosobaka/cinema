class Channel < ApplicationRecord
  has_many :channel_users, dependent: :destroy
  has_many :users, through: :channel_users
  has_many :messages, dependent: :destroy
  belongs_to :author, class_name: 'User', foreign_key: :user_id

  validates :name, presence: true, length: {maximum: 18}, uniqueness: true
  validates :author, presence: true
  validate :author_channel_count

  def author_channel_count
    if author.channel_author.count > 6
      errors.add(:name, "Не больше 6 созданных каналов на пользователя.")
    end
  end
end
