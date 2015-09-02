 require 'faker'
 10.times do 

  user = User.new(
    name:  Faker::Name.name,
    email:  Faker::Internet.email,
    password: Faker::Lorem.characters(8))
  user.save!
end

user = User.new(
  name: 'User',
  email: 'user@example.com',
  password: 'helloworld')
user.save!

user = User.new(
  name: 'admin',
  email: 'admin@example.com',
  password: 'helloworld')
user.save!

user = User.new(
  name: 'owner',
  email: 'owner@example.com',
  password: 'helloworld')
user.save!

users = User.all

20.times do
  trip = Trip.new(
    user: users.sample,
    name: Faker::Lorem.word
    )
  trip.save!
end

trips = Trip.all

20.times do
  poll = Poll.new(
    trip: trips.sample,
    topic: Faker::Lorem.sentence(3)
    )
  poll.save!
end

polls = Poll.all

25.times do
  poll_option = PollOption.new(
    poll: polls.sample,
    title: Faker::Lorem.word
    )
  poll_option.save!
end
puts "Seeding Finished"
puts "#{User.count} users created."
puts "#{Trip.count} topics created."
puts "#{Poll.count} polls created"
puts "#{PollOption.count} poll options created"