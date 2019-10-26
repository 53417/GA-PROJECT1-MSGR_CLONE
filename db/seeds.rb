# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

include BCrypt

user1 = User.create(displayname: 'user1', password_digest: Password.create('password'), age: 21, username: 'login1');
user2 = User.create(displayname: 'user2', password_digest: Password.create('password'), age: 22, username: 'login2');
user3 = User.create(displayname: 'user3', password_digest: Password.create('password'), age: 23, username: 'login3');

room1 = Chatroom.create(user_id: user1.id, room_name: 'room1');
room2 = Chatroom.create(user_id: user2.id, room_name: 'room2');
room3 = Chatroom.create(user_id: user3.id, room_name: 'room3');

ChatroomUser.create(user_id: user1.id, chatroom_id: room1.id, is_admin: true);
ChatroomUser.create(user_id: user2.id, chatroom_id: room1.id, is_admin: false);
ChatroomUser.create(user_id: user3.id, chatroom_id: room1.id, is_admin: false);
ChatroomUser.create(user_id: user2.id, chatroom_id: room2.id, is_admin: true);
ChatroomUser.create(user_id: user1.id, chatroom_id: room2.id, is_admin: false);
ChatroomUser.create(user_id: user3.id, chatroom_id: room3.id, is_admin: true);

ChatroomMessage.create(user_id: user1.id, chatroom_id: room1.id, message: 'message1');
ChatroomMessage.create(user_id: user1.id, chatroom_id: room1.id, message: 'message2');
ChatroomMessage.create(user_id: user1.id, chatroom_id: room1.id, message: 'message3');
ChatroomMessage.create(user_id: user2.id, chatroom_id: room1.id, message: '2s message');
ChatroomMessage.create(user_id: user2.id, chatroom_id: room2.id, message: 'init 2');
ChatroomMessage.create(user_id: user3.id, chatroom_id: room3.id, message: 'init 3');

UserFriend.create(user_id: user1.id, friend_id: user2.id)
UserFriend.create(user_id: user2.id, friend_id: user1.id)
UserFriend.create(user_id: user1.id, friend_id: user3.id)
UserFriend.create(user_id: user3.id, friend_id: user1.id)