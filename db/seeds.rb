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

users = User.order(:name).take(6)
50.times do
  name  = Faker::Name.name
  phone = "619-123-4567"
  license_plate = "ABC4567"
  users.each { |user| user.customers.create!(name: name,  phone: phone,
                                              license_plate: license_plate) }
end