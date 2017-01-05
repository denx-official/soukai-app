User.create!(name:  "odk",
             email: "bmp1069@mail4.doshisha.ac.jp",
             password:              "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now,
             entrance_year: 2016)

if Rails.env.development?
  30.times do |n|
    name  = Faker::Name.name
    mail = "exm#{n+1000}@mail4.doshisha.ac.jp"
    entrance_year = (2006..2016).to_a.sample
    User.create!(name:  name,
                 email: mail,
                 password:              "password",
                 password_confirmation: "password",
                 activated: true,
                 activated_at: Time.zone.now,
                 entrance_year: entrance_year)
  end
end

12.times do |m|
  Soukai.create!(name: (m+1).to_s+"月総会",
                 date:  Date.new(2016, m+1, 10),
                 password:  "soukaiyazo",
                 password_confirmation: "soukaiyazo",)
  att_user = (1..19).to_a.sort_by{rand}[0..15]
  att_user.size.times do |n|
    Attendance.create!(soukai_id: m+1,
                       user_id: att_user[n])
  end
end

(1..3).each do |project_id|
  Project.create!(name: (project_id).to_s+"月プロジェクト",
                  soukai_id: project_id,
                  user_id: 1)
  
  (1..3).each do |i|
    ProjectOption.create!(
                          name: "オプション" + i.to_s,
                          price: 20000,
                          project_id: project_id,
                          remarks: "そり"
                          )
  end
end

user_id = (1..19).to_a.sort_by{rand}
12.times do |i|
  Vote.create(project_id: 1,
               user_id: user_id[i],
               project_option_id: (0..3).to_a.sample)
end
12.times do |i|
  Vote.create(project_id: 2,
               user_id: user_id[i],
               project_option_id: (4..6).to_a.sample)
end
12.times do |i|
  Vote.create(project_id: 3,
               user_id: user_id[i],
               project_option_id: (7..9).to_a.sample)
end

3.times do |i|
  ShareThing.create(
    name: "content#{i}",
    content: "content#{i*100}",
    content_type_id: 2)
end