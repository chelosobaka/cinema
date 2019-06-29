class CreateVoterSessions < ActiveRecord::Migration[5.2]
  def change
    create_table :voter_sessions do |t|
      t.string :session_id

      t.timestamps
    end
  end
end
