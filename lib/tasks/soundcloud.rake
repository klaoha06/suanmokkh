require 'soundcloud'

task :update_soundcloud => :environment do
  p 'Number of audio before update = ' + (Audio.all.count).to_s
  p 'Updating audios from Soundcloud..'
  @audio_updated = 0
  @retreat_talk_updated = 0
  @created = 0
  def update_tracks(sc_tracks)

    def track_title(track)
      track.title.gsub(/\d{6}|[(]\d[)]/, '').strip
    end

    def track_cover_img(track)
      if !track.artwork_url.blank?
        track.artwork_url.gsub('large', 't300x300')
      else
        'ajarn-lan-'+ (Random.rand(5)+1).to_s + '.jpg'
      end
    end

    sc_tracks.each do |track|

      audio = Audio.where(soundcloud_identifier: track.id).first
      english = Language.where(name: 'English')
      buddhadasa = Author.where(name: 'Buddhadasa')

      if audio && !audio.do_not_update_from_soundcloud

        audio.assign_attributes({ title: track_title(track), uri: track.uri, secret_uri: track.secret_uri, audio_code: track.title.match(/\d{6}/).to_s, part: track.title.match(/\([^)]\)/).to_s, duration: track.duration.to_i, description: track.description })
        if audio.changed?
          audio.save
          @audio_updated += 1
        end

        retreat_talk = audio.retreat_talks.first
        if retreat_talk && !retreat_talk.do_not_update_from_soundcloud
          retreat_talk.assign_attributes({title: track_title(track), description: track.description, external_cover_img_link: track_cover_img(track), translator: 'Santikaro'})
          if retreat_talk.changed?
            retreat_talk.save
            @retreat_talk_updated += 1
          end
        end
      elsif audio.blank?
        a = Audio.create!({soundcloud_identifier: track.id.to_i, title: track_title(track), uri: track.uri, secret_uri: track.secret_uri, audio_code: track.title.match(/\d{6}/).to_s, part: track.title.match(/\([^)]\)/).to_s, duration: track.duration.to_i, description: track.description })
        r = RetreatTalk.create({title: track_title(track), description: track.description, external_cover_img_link: track_cover_img(track), translator: 'Santikaro'})

        a.languages << english
        a.authors << buddhadasa

        r.languages << english
        r.authors << buddhadasa

        a.retreat_talks << r
        @created += 1
      end

    end
  end #update_tracks

  @sc_tracks = $sc_consumer.get('/users/159428232/tracks', :order => 'created_at', limit: 200)
  @sc_tracks1 = $sc_consumer.get('/users/159428232/tracks', :order => 'created_at', limit: 200, offset: 200)

  update_tracks(@sc_tracks)
  update_tracks(@sc_tracks1)
  p 'audio and retreat_talk created = ' + @created.to_s
  p 'audio updated = ' + @audio_updated.to_s
  p 'retreat_talks updated = ' + @retreat_talk_updated.to_s
  p 'datetime = ' + (Time.now.strftime("%Y-%m-%d %I:%M%p")).to_s
  p 'number of audios = ' + (Audio.all.count).to_s
end


