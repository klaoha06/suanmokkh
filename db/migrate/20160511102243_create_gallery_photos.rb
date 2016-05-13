class CreateGalleryPhotos < ActiveRecord::Migration
  def change
    create_table :gallery_photos do |t|
      t.text :external_img_link
      t.text :caption

      t.timestamps null: false
    end
  end
end
