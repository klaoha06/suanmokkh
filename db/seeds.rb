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
["Thai", "English", "Spanish"].each do |language|
  Language.create({name: language});
end

10.times do
  author = Author.create({ name: Faker::Name.name, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, brief_biography: Faker::Lorem.paragraph })
  2.times do
    book = author.books.new({
      title: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      external_file_link: Faker::Internet.url,
      external_cover_img_link: Faker::Internet.url,
      featured: [true, false].sample(1)
    })

    book.languages << Language.all.sample(1)
    book.save!
  end
end

# Author.create!([{ name: 'Ajarn Buddhadasa' }, { name: 'YOYOYO' },{ name: 'Ajarn Jayasaro'}, { name: 'Thich Nhat Han' }])

# user.products.create(:name => 'Apple', :store => walmart)


