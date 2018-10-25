# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

tags = ["fundamentals", "cryptography", "distributed systems", "game theory", "networking", "consensus", "scalability", "economics", "bitcoin", "ethereum", "smart contracts", "infrastructure", "IPFS", "identity", "privacy", "securities"]

25.times do |i|
  User.create(
    email: "user#{i}@mail.com",
    password: "password",
    name: Faker::Name.name,
    bio: Faker::GreekPhilosophers.quote,
    display_email: 0,
  )

  Article.create(
    title: Faker::Book.title,
    description: Faker::Movie.quote,
    content: Faker::Lorem.paragraph(3),
    source: Faker::Internet.url,
    source_date: Faker::Date.backward(300),
    views: rand(300),
    user_id: rand(25),
  )

  # FIXME
  # i += 1
  # ArticlesTag.create(
  #   article_id: i,
  #   tag_id: rand(tags.length - 1),
  # )
end

75.times do |i|
  Comment.create(
    title: Faker::Book.title,
    content: Faker::ChuckNorris.fact,
    rate: rand(6),
    user_id: rand(25),
    article_id: rand(25),
  )
end

tags.each do |tag|
  Tag.create(name: tag)
end

# FIXME
# users.each do |user_id|
#   ? Votes.create(
#     votable_type: "Article",
#     votable_id: rand(11),
#     voter_type: "User",
#     voter_id: user_id,
#     vote_flag: true,
#     vote_weight: 1,
#   )
# end
