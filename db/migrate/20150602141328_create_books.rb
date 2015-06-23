class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.text :external_url_link
      t.text :external_cover_img_link
      t.text :external_file_link
      t.string :language
      t.string :series
      t.string :group
      t.date :creation_date

      t.string :isbn_10
      t.string :isbn_13
      t.date :publication_date

      t.boolean :draft, default: false
      t.boolean :featured, default: false
      t.boolean :allow_comments, default: true
      t.boolean :recommended, default: false
      
      t.string :format
      t.float :weight
      t.integer :pages
      t.decimal :price, :precision => 8, :scale => 2
      t.string :currency

      t.integer :downloads, default: 0
      t.integer :views, default: 0
      t.integer :shares, default: 0

      t.belongs_to :admin_user, index:true

      t.timestamps null: false
    end
  end
end