Product.delete_all

(1..12).each do
  Product.create!( title: Faker::Commerce.product_name,
                   description: Faker::Lorem.paragraph(10),
                   price: Faker::Commerce.price)
end