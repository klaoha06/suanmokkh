# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

Poem.create!([{title: 'Buddhadasa Never Dies', content: "Buddhadasa shall live, there's no dying. 
Even when the body dies, it will not listen. 
Whether it is or goes is of no consequence, 
it is only something passing through time.

Buddhadasa carries on, there's no dying. 
However good or bad the times, 
always one with the true teaching. 
Having offered body and mind in ceaseless service 
Under Lord Buddha's command.

Buddhadasa lives on, there's no dying. 
In service to all humanity forever 
through the Dhamma Proclamations left behind -- 
O, Friends, can't you see! What dies?

Even when I die and the body ceases 
my voice still echoes in comrades' ears 
clear and bright, as loud as ever. 
Just as if I never died the Dhamma-body lives on.

Treat me as if I never died, 
as though I am with you all as before. 
Speak up whatever is on your minds 
as if I sit with you helping point out the facts.

Treat me as if I never died, then 
many streams of benefits will accrue. 
Don't forget the days we set aside for Dhamma discussion; 
Realize the Absolute and stop dying!", external_cover_img_link: 'ajarn1.jpg' }, {title: 'Buddhadasa', content: "I offer this life and body to the Buddha,

the Buddha is my master, 

I am the Buddha's servant. 

Thus, I am called 'Buddhadasa.'", external_cover_img_link: 'ajarn2.jpg'}])

12.times do |i|
  Poem.create!({title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, external_cover_img_link: ('ajarn' + (i+1).to_s + '.jpg' )})
end

Language.create!([{name: 'English'}, {name: 'Thai'}, {name: 'German'}, {name: 'Chinese'}, {name: 'Russian'}, {name: 'Japanese'}, {name: 'French'}, {name: 'Korean'}])
buddhadasa = Author.create!([{name: 'Buddhadasa'}])

20.times do |i|
  book = Book.create!({title: Faker::Lorem.sentence, description: Faker::Lorem.paragraph(18), external_file_link: 'http://www.suanmokkh-idh.org/talks/chanting-book-ver1-02.pdf', external_cover_img_link: 'http://placehold.it/250x320', draft: false, featured: true, recommended: true })
  book.authors << buddhadasa
  book.languages << Language.where(name: 'English')
end

def seed_tracks(sc_tracks)
  sc_tracks.each_with_index do |track, index|

    a_title = track.title.gsub(/\d{6}|[(]\d[)]/, '').strip
    if track.artwork_url != nil
      a_cover_img = track.artwork_url.gsub('large', 't300x300')
    else
      a_cover_img = 'ajarn-lan-'+ (Random.rand(5)+1).to_s + '.jpg'
    end

    english = Language.where(name: 'English')
    buddhadasa = Author.where(name: 'Buddhadasa')

    if index < 6 
      a = Audio.create({ title: a_title, uri: track.uri, secret_uri: track.secret_uri, audio_code: track.title.match(/\d{6}/).to_s, part: track.title.match(/\([^)]\)/).to_s, duration: track.duration.to_i, description: track.description, featured: true, recommended: true })
      retreat_talk = RetreatTalk.create({title: a_title, description: track.description, external_cover_img_link: a_cover_img, draft: false, featured: true, recommended: true, translator: 'Santikaro' })
    else
      a = Audio.create({ title: a_title, uri: track.uri, secret_uri: track.secret_uri, audio_code: track.title.match(/\d{6}/).to_s, part: track.title.match(/\([^)]\)/).to_s, duration: track.duration.to_i, description: track.description })
      retreat_talk = RetreatTalk.create({title: a_title, description: track.description, external_cover_img_link: a_cover_img, draft: false, translator: 'Santikaro'})
    end
    a.languages << english
    a.authors << buddhadasa

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


