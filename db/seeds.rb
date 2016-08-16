User.create!(name:  "odk",
             email: "bmp1069@mail4.doshisha.ac.jp",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)
             
49.times do |n|
  name  = Faker::Name.name
  email = "exm#{n+1000}@mail4.doshisha.ac.jp"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              "password",
               password_confirmation: "password",
               activated: true,
               activated_at: Time.zone.now)
end

12.times do |m|
  Soukai.create!(month: m+1,
                 year:  2016,
                 password:  "soukaiyazo")
  att_user = (1..51).to_a.sort_by{rand}[0..15]
  att_user.size.times do |n|
    Attendance.create!(soukai_id: m+1,
                       user_id: att_user[n])
  end
end