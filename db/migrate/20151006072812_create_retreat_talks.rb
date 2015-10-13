class CreateRetreatTalks < ActiveRecord::Migration
  def change
    create_table :retreat_talks do |t|
    	t.string :title
    	t.text :description
    	t.string :series
    	t.string :duration
    	t.string :audio_code
      t.string :format
      t.string :series
      t.string :group

      # t.text :embeded_audio_link
      # t.text :external_url_link
      t.text :external_cover_img_link
      t.string :language

      t.date :publication_date

      t.boolean :draft, default: false
      t.boolean :featured, default: false
      t.boolean :allow_comments, default: true
      t.boolean :recommended, default: false
      

      t.integer :downloads, default: 0
      t.integer :views, default: 0
      t.integer :shares, default: 0

      t.belongs_to :admin_user, index:true

      t.timestamps null: false
    end
  end
end
