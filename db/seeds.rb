# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 50.times do
#   Post.create title: Faker::Name.title,
#               body:Faker::Lorem.sentence
# end
#
# 50.times do
#   Comment.create body: Faker::Lorem.sentence
# end

["Art", "Science", "Cats", "Sports", "Technology", "Game", "Code", "Dogs", "Food", "Music"].each do |cat|
  Category.create(name: cat)
end
