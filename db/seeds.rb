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

users = User.order(:name).take(5)
5.times do
  name  = Faker::Name.name
  phone = "619-123-4567"
  license_plate = "ABC4567"
  users.each { |user| user.customers.create!(name: name,  phone: phone,
                                              license_plate: license_plate) }
end

customers = Customer.order(:created_at)
5.times do
  content = {"odo" => 123, "original_estimate" => 1, "invoice" => 112}
  customers.each { |customer| customer.pdf_forms.create!(content: content) }
end

pdfs = PdfForm.order(:created_at)
2.times do
  op = Faker::Number.digit 
  instruction = Faker::Lorem.sentence
  svc = Faker::Number.digit
  pdfs.each { |pdf| pdf.repairs.create!(op: op, instruction: instruction,
                                                      svc: svc) }
end

3.times do |x|
  make  = Make.find_or_create_by(:name => "make #{x}")
  3.times do |y|
    model = Model.find_or_create_by(:name => "Model #{x}.#{y}", :make => make)
    3.times do |z|
      Year.find_or_create_by(:name => "Year #{x}.#{y}.#{z}",  :model => model)
    end
  end
end

10.times do |n|
  name  = Faker::Name.name
  Trim.create!(name: name)
end



