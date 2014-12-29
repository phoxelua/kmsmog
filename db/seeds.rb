User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             organization: "Example Org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  organization = name
  password = "password"
  User.create!(name:  name,
               email: email,
               organization: organization,
               password:              password,
               password_confirmation: password)
end