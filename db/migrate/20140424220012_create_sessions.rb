class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :user_id, null: false
      t.string :session_token, null: false

      t.timestamps
    end
  end
end
