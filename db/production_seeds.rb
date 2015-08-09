require 'csv'

case Rails.env
  when "production"
	  User.create!(name:  "hao",
				   email: "howardanguyen@gmail.com",
				   organization: "sudoer",
				   password:              ENV["ADMIN_KEY"],
				   password_confirmation: ENV["ADMIN_KEY"],
				   admin: true)

		puts "Importing make..."
		CSV.foreach(Rails.root.join("make.csv"), headers: false) do |row|
		  Make.create! do |make|
			make.id = row[0]
			make.name = row[1]
		  end
		end

		puts "Importing model..."
		CSV.foreach(Rails.root.join("model.csv"), headers: false) do |row|
		  Model.create! do |model|
			model.make_id = row[1]
			model.name = row[0]
		  end
		end

		puts "Importing trims..."
		["80", "Sedan", "2WD", "4x4", "AWD", "C", "DX", "EX", "FWD", "HX", "LS", "LX", "M", "RWD", "Wagon"].each do |name|
		  Trim.create!(name: name)
		end
end

