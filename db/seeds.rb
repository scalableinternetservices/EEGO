# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Adventure.create(location: "a", num_people: 2, num_day: 3, plan: "Hiking", user_id: 1);
Adventure.create(location: "a", num_people: 2, num_day: 3, plan: "Hiking", user_id: 2);
Adventure.create(location: "a", num_people: 3, num_day: 3, plan: "Hiking", user_id: 3);
Adventure.create(location: "a", num_people: 4, num_day: 3, plan: "Hiking", user_id: 2);
Adventure.create(location: "b", num_people: 5, num_day: 3, plan: "Hiking", user_id: 1);
Adventure.create(location: "b", num_people: 34, num_day: 3, plan: "Hiking", user_id: 2);
Adventure.create(location: "c", num_people: 1, num_day: 3, plan: "Hiking", user_id: 4);
Adventure.create(location: "c", num_people: 10, num_day: 3, plan: "Hiking", user_id: 3);
Adventure.create(location: "a", num_people: 2, num_day: 3, plan: "Hiking", user_id: 4);
Adventure.create(location: "a", num_people: 4, num_day: 3, plan: "Hiking", user_id: 2);
Adventure.create(location: "b", num_people: 6, num_day: 3, plan: "Hiking", user_id: 4);
Adventure.create(location: "c", num_people: 7, num_day: 3, plan: "Hiking", user_id: 3);
Adventure.create(location: "a", num_people: 8, num_day: 3, plan: "Hiking", user_id: 1);
Adventure.create(location: "b", num_people: 70, num_day: 3, plan: "Hiking", user_id: 2);
Adventure.create(location: "c", num_people: 23, num_day: 3, plan: "Hiking", user_id: 1);
Adventure.create(location: "a", num_people: 12, num_day: 3, plan: "Hiking", user_id: 1);


User.create(email: "123@ucla.edu", password: "11111111", password_confirmation: "11111111");
User.create(email: "234@ucla.edu", password: "22222222", password_confirmation: "22222222");
User.create(email: "345@ucla.edu", password: "33333333", password_confirmation: "33333333");
User.create(email: "456@ucla.edu", password: "44444444", password_confirmation: "44444444");
