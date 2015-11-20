# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "start seeding"

number_of_advenetures = 100
number_of_users = 100

def
  create_adventure(location_creater)
  Adventure.create(
      location: location_creater,
      num_people: rand(1..99),
      num_day: rand(1..99),
      plan: "Hiking " + rand(1..5).to_s + " places",
      user_id: rand(1..99)
  )
end

# create adventures
puts "Create adventures with location a"
number_of_advenetures.times do
  create_adventure("a")
end

puts "Create adventures with location b"
number_of_advenetures.times do
  create_adventure("b")
end

puts "Create adventures with location c"
number_of_advenetures.times do
  create_adventure("c")
end

# create users
puts "Create users"
number_of_users.times do |n_user|
  User.create(
      email: n_user.to_s + "@ucla.edu",
      password: "11111111",
      password_confirmation: "11111111",
  )
end

puts "end seeding"
