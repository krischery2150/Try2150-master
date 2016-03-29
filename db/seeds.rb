User.create!(first_name:  "Example",
             last_name: "User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")

99.times do |n|
  first_name  = Faker::Name.name
  last_name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(first_name:  first_name,
              last_name: last_name,
               email: email,
               password:              password,
               password_confirmation: password)
end
