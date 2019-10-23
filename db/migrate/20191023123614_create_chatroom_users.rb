class CreateChatroomUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :chatroom_users do |t|

      t.timestamps
    end
  end
end
