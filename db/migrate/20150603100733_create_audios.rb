class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
    	t.string :title
    	t.text :description
    	# t.string :language
    	t.string :series
    	# t.string :group
    	t.date :creation_date
    	t.string :duration
    	t.string :audio_code

    	t.text :embeded_audio_link
    	t.text :external_link

    	t.boolean :draft, default: false
    	t.boolean :featured, default: false
    	t.boolean :allow_comments, default: true

    	t.integer :downloads, default: 0
    	t.integer :plays, default: 0
    	t.integer :shares, default: 0

        t.belongs_to :admin_user, index:true

      t.timestamps null: false
    end
  end
end
