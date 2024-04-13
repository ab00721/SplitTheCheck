# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Restaurant.create(name: "Boca", location: "Sarasota")
Restaurant.create(name: "State Street", location: "Sarasota")
Restaurant.create(name: "Oak and Stone", location: "Sarasota")
Restaurant.create(name: "The Rosemary", location: "Sarasota")
Restaurant.create(name: "Rocco's Tacos", location: "Delray")
Restaurant.create(name: "Pizza Rustica", location: "Delray")
Restaurant.create(name: "Vic and Angelo's", location: "Delray")
Restaurant.create(name: "Benny's", location: "Lake Worth")
Restaurant.create(name: "Copperfish", location: "Boca")

20.times do |i|
  User.create(email: "user#{i+1}@email.com", password: "password")
end

User.all.each do |user|
  restaurants = Restaurant.order(Arel.sql('Random()')).limit(3)
  restaurants.each do |restaurant|
    random_boolean = [true, false].sample
    Vote.create(user: user, restaurant: restaurant, vote: random_boolean)
  end
end
