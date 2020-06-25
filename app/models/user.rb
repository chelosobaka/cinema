class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :favorite
  has_many :channel_users, dependent: :destroy
  has_many :channels, through: :channel_users
  has_many :channel_author, class_name: 'Channel', foreign_key: :user_id, dependent: :destroy
  has_many :messages, dependent: :destroy

  def account_active?
    !blocked
  end

  def active_for_authentication?
    super && account_active?
  end

  def inactive_message
    account_active? ? super : :locked
  end
end
