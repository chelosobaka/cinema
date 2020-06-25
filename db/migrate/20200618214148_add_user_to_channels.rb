class AddUserToChannels < ActiveRecord::Migration[5.2]
  def change
    add_reference :channels, :user, foreign_key: true
  end
end
