User.create!(username:  "Alex Nagatkin",
             email: "alex.nagatkin@gmail.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin:true)


99.times do |n|
  username  = Faker::Name.name
  email = "alex-#{n+1}@gmail.com"
  password = "password"
  User.create!(username:  username,
               email: email,
               password:              password,
               password_confirmation: password,
              )
end
