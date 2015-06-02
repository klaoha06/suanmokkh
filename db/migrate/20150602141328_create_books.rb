class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :path
      t.string :cover_img
      t.integer :downloads
      t.string :description
      t.string :title
      t.string :group
      t.string :isbn_10
      t.string :isbn_13
      t.string :language
      t.string :series
      t.string :publisher

      t.timestamps null: false
    end
  end
end
