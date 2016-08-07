# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "odk",
             email: "bmp1069@mail4.doshisha.ac.jp",
             password:              "password",
             password_confirmation: "password",
             admin: true)

49.times do |n|
  name  = Faker::Name.name
  email = "exm#{n+1000}@mail4.doshisha.ac.jp"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end