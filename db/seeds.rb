User.create!(name:  "taducdung",
  email: "taducdung1995@gmail.com",
  password: "tadung95",
  password_confirmation: "tadung95",
  admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
