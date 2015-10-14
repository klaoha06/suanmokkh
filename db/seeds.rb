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

Language.create!([{name: 'English'}, {name: 'Thai'}, {name: 'German'}, {name: 'Chinese'}, {name: 'Russian'}, {name: 'Japanese'}, {name: 'French'}, {name: 'Korean'}])
Author.create!([{name: 'Buddhadasa'}])

def seed_tracks(sc_tracks)
  sc_tracks.each do |track|

    a_title = track.title.gsub(/\d{6}|[(]\d[)]/, '').strip
    if track.artwork_url != nil
      a_cover_img = track.artwork_url.gsub('large', 't300x300')
    else
      a_cover_img = 'ajarn-lan-'+ (Random.rand(5)+1).to_s + '.jpg'
    end

    english = Language.where(name: 'English')
    buddhadasa = Author.where(name: 'Buddhadasa')

    a = Audio.create({ title: a_title, secret_uri: track.secret_uri, audio_code: track.title.match(/\d{6}/).to_s, part: track.title.match(/\([^)]\)/).to_s, duration: track.duration.to_i, description: track.description })
    a.languages << english
    a.authors << buddhadasa

    retreat_talk = RetreatTalk.create({title: a_title, description: track.description, external_cover_img_link: a_cover_img, draft: true})
    retreat_talk.languages << english
    retreat_talk.authors << buddhadasa

    a.retreat_talks << retreat_talk
  end
end


@sc_tracks = $sc_consumer.get('/users/159428232/tracks', :order => 'created_at', limit: 200)
@sc_tracks1 = $sc_consumer.get('/users/159428232/tracks', :order => 'created_at', limit: 200, offset: 200)

seed_tracks(@sc_tracks)
seed_tracks(@sc_tracks1)

# Author.create!([{ name: 'Ajarn Buddhadasa' }, { name: 'YOYOYO' },{ name: 'Ajarn Jayasaro'}, { name: 'Thich Nhat Han' }])

# user.products.create(:name => 'Apple', :store => walmart)


