# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'


Author.delete_all
Book.delete_all

10.times do 
	author = Author.create({ name: Faker::Name.name, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, brief_biography: Faker::Lorem.paragraph })
	2.times do 
		author.books.create({title: Faker::Commerce.product_name, description: Faker::Lorem.paragraph })
		# Book.create!({ title: Faker::Commerce.product_name })
	end
end

# Author.create!([{ name: 'Ajarn Buddhadasa' }, { name: 'YOYOYO' },{ name: 'Ajarn Jayasaro'}, { name: 'Thich Nhat Han' }])

# user.products.create(:name => 'Apple', :store => walmart)


