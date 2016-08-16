User.create!(name:  "odk",
             email: "bmp1069@mail4.doshisha.ac.jp",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
Attendance.create!(jan: nil)

49.times do |n|
  name  = Faker::Name.name
  email = "exm#{n+1000}@mail4.doshisha.ac.jp"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
  Attendance.create!(jan: nil)
end