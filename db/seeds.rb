# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# drivers = []
# groups = []

# 5.times do |i|
#   d = Driver.create(name: "Driver #{i}")
#   g = Group.create(name: "Group #{i}")

#   drivers.push(d.id)
#   groups.push(g.id)
# end

# drivers.each do |driver_id|
#   DriversGroup.create(driver_id: driver_id, group_id: groups[rand(groups.length - 1)])
#   Avatar.create(image: "image.png", driver_id: driver_id) if rand(2).to_i == 1
# end

50.times do |i|
  User.create(
    email: Faker::Internet.username,
    password: "password",
    name: Faker::Name.name,
    bio: Faker::GreekPhilosophers.quote,
    display_email: 0,
  )

  #   Article.create(
  #     title: Faker::Book.title,
  #     description: Faker::Movie.quote,
  #     content: Faker::Lorem.paragraph(3),
  #     source: Faker::Internet.url,
  #     source_date: Faker::Date.backward(300),
  #     views: rand(300),
  #     user_id: rand(11),
  #   )

  #   Comment.create(
  #     title: "Comment title",
  #     content: Faker::ChuckNorris.fact,
  #     rate: rand(6),
  #     user_id: rand(11),
  #     article_id: rand(11),
  #   )
end

# users.each do |user_id|
#   Votable????.create(
#     votable_type: "Article",
#     votable_id: rand(11),
#     voter_type: "User",
#     voter_id: user_id,
#     vote_flag: true,
#     vote_weight: 1,
#   )
# end
