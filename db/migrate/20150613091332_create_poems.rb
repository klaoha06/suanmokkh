class CreatePoems < ActiveRecord::Migration
  def change
    create_table :poems do |t|
    	t.string :title
    	t.text :content
    	# t.string :author
      # t.string :language
      t.text :external_cover_img_link
      t.string :series
      # t.string :group
      t.date :creation_date

      # t.integer :views, default: 0
      # t.integer :shares, default: 0

      t.boolean :draft, default: false
      t.boolean :featured, default: false
      # t.boolean :allow_comments, default: true

      t.belongs_to :admin_user, index:true

      t.timestamps null: false
    end
  end
end
