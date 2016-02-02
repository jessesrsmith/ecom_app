Product.delete_all

(1..12).each do
  Product.create!(title: Faker::Commerce.product_name,
                  description: Faker::Lorem.paragraph(40),
                  price: Faker::Commerce.price)
end

User.delete_all

User.create!(name: "Test User", 
             email: "test@test.com",
             password: "foobar",
             password_confirmation: "foobar")

(1..100).each do
  User.create!(name: Faker::Name.name, 
               email: Faker::Internet.email,
               password: "foobar",
               password_confirmation: "foobar")
end