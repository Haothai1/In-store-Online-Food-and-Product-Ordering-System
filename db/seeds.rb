# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Food items sampel data
Product.create(name: 'Burger', description: 'Juicy beef burger', price: 9.99, category: 'Food')
Product.create(name: 'Pizza', description: 'Margherita pizza', price: 12.99, category: 'Food')

# Store items sample data 
Product.create(name: 'T-shirt', description: 'Cotton t-shirt with logo', price: 19.99, category: 'Store')
Product.create(name: 'Mug', description: 'Ceramic mug with logo', price: 7.99, category: 'Store')

[
  { name: 'Burger', description: 'Juicy beef burger', price: 9.99, category: 'Food', stock_quantity: 50 },
  { name: 'Pizza', description: 'Margherita pizza', price: 12.99, category: 'Food', stock_quantity: 30 },
  { name: 'T-shirt', description: 'Cotton t-shirt with logo', price: 19.99, category: 'Store', stock_quantity: 100 },
  { name: 'Mug', description: 'Ceramic mug with logo', price: 7.99, category: 'Store', stock_quantity: 200 }
].each do |product_attributes|
  product = Product.new(product_attributes)
  if product.save
    puts "Created #{product.name}"
  else
    puts "Failed to create #{product_attributes[:name]}: #{product.errors.full_messages.join(', ')}"
  end
end
