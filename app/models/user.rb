class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :favorite

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
