# frozen_string_literal: true

20.times do |_n|
  Book.create!(
    title: Faker::Book.title,
    author: Faker::Book.author,
    image: Faker::Avatar.image
  )
end
p 'created books'

10.times do |_n|
  User.create(
    email: Faker::Internet.email,
    password: 'test_user'
  )
end
p 'created users'

100.times do |_n|
  Review.create!(
    title: Faker::Lorem.sentences(number: 1)[0],
    content_rating: Faker::Number.between(from: 1, to: 10),
    recommend_rating: Faker::Number.between(from: 1, to: 10),
    user_id: Faker::Number.between(from: 1, to: 10),
    book_id: Faker::Number.between(from: 1, to: 20)
  )
end
p 'created reviews'
