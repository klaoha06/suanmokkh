class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :external_link
      t.string :language
      t.string :series
      t.string :group

      t.string :isbn_10
      t.string :isbn_13
      # t.string :publisher
      t.date :publication_date

      t.boolean :draft, default: false
      t.boolean :featured, default: false
      t.boolean :allow_comments, default: true
      
      t.string :format
      t.integer :weight
      t.integer :pages
      t.decimal :price, :precision => 8, :scale => 2

      t.integer :downloads, default: 0
      t.integer :views, default: 0
      t.integer :shares, default: 0

      # t.belongs_to :publisher, index:true

      t.timestamps null: false
    end
  end
end