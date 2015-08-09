require 'csv'

case Rails.env
when "development"
  User.create!(name:  "Example User",
               email: "example@railstutorial.org",
               organization: "Example Org",
               password:              "foobar",
               password_confirmation: "foobar",
               admin: true)

  10.times do |n|
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

  puts "Importing menus..."
  users = User.order(:name).take(5)
  5.times do
    service = Faker::Commerce.product_name
    price = Faker::Commerce.price
    users.each { |user| user.menus.create!(service: service,  price: price) }
  end

  puts "Importing users..."
  users = User.order(:name).take(5)
  5.times do
    name  = Faker::Name.name
    phone = "619-123-4567"
    license_plate = "ABC4567"
    users.each { |user| user.customers.create!(name: name,  phone: phone,
                                                license_plate: license_plate) }
  end

  puts "Importing customers..."
  customers = Customer.order(:created_at)
  5.times do
    content = {"odo" => 123, "original_estimate" => 1, "invoice" => 112}
    customers.each { |customer| 
      customer.pdf_forms.create!(content: content.merge({"name" => customer.name, "phone" => customer.phone, "license_plate" => customer.license_plate})) }
  end

  puts "Importing pdfs..."
  pdfs = PdfForm.order(:created_at)
  2.times do
    op = Faker::Number.digit 
    instruction = Faker::Lorem.sentence
    svc = Faker::Number.digit
    pdfs.each { |pdf| pdf.repairs.create!(op: op, instruction: instruction,
                                                        svc: svc) }
  end

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


  # 3.times do |x|
  #   make  = Make.find_or_create_by(:name => "make #{x}")
  #   3.times do |y|
  #     model = Model.find_or_create_by(:name => "Model #{x}.#{y}", :make => make)
  #     3.times do |z|
  #       Year.find_or_create_by(:name => "Year #{x}.#{y}.#{z}",  :model => model)
  #     end
  #   end
  # end

  puts "Importing trims..."
  ["80", "Sedan", "2WD", "4x4", "AWD", "C", "DX", "EX", "FWD", "HX", "LS", "LX", "M", "RWD", "Wagon"].each do |name|
    Trim.create!(name: name)
  end

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
else
  puts "idc"
end



