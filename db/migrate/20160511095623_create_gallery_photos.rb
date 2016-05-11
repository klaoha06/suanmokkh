class CreateGalleryPhotos < ActiveRecord::Migration
  def change
    create_table :gallery_photos do |t|
    	t.text :external_cover_img_link

      t.timestamps null: false
    end
  end
end
