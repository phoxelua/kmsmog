require 'csv'

case Rails.env
  when "production"
  User.create!(name:  "hao",
               email: "howardanguyen@gmail.com",
               organization: "sudoer",
               password:              ENV["ADMIN_KEY"],
               password_confirmation: ENV["ADMIN_KEY"],
               admin: true)
end

