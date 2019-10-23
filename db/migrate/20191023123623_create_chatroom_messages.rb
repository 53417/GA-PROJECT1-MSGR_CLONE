class CreateChatroomMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :chatroom_messages do |t|

      t.timestamps
    end
  end
end
