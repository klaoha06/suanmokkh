# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'


# Author.delete_all
# Book.delete_all
# ["Thai", "English", "Spanish"].each do |language|
#   Language.create({name: language});
# end

# 10.times do
#   author = Author.create({ name: Faker::Name.name, first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, brief_biography: Faker::Lorem.paragraph })
#   2.times do
#     book = author.books.new({
#       title: Faker::Commerce.product_name,
#       description: Faker::Lorem.paragraph,
#       external_file_link: Faker::Internet.url,
#       external_cover_img_link: Faker::Internet.url,
#       featured: [true, false].sample(1)[0],
#       series: ["1", "2"].sample(1)[0]
#     })

#     book.languages << Language.all.sample(1)
#     book.save!
#     author.books << book
#     author.save!
#   end
# end

# @search =  Audio.search(params[:q])
# @audios = @search.result


@sc_tracks = $sc_consumer.get('/users/159428232/tracks', :order => 'created_at', limit: 200)
@sc_tracks1 = $sc_consumer.get('/users/159428232/tracks', :order => 'created_at', limit: 200, offset: 200)

@sc_tracks.each do |track|
  Audio.create!({ title: track.title, secret_uri: track.secret_uri})
end

@sc_tracks1.each do |track|
  Audio.create!({ title: track.title, secret_uri: track.secret_uri})
end

# @sc_tracks_with_pagination_link.each_with_index do |object, index|
# if index == 0
#   @sc_info = object[0]
#   @sc_tracks = object[1]
# end
# if index == 1
#   @sc_pagination_link = object[1]
# end
# end

# Author.create!([{ name: 'Ajarn Buddhadasa' }, { name: 'YOYOYO' },{ name: 'Ajarn Jayasaro'}, { name: 'Thich Nhat Han' }])

# user.products.create(:name => 'Apple', :store => walmart)


