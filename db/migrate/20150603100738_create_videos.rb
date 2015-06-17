class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
    	t.string :title
    	t.text :description
    	# t.string :language
    	t.integer :downloads, default: 0
    	t.integer :plays, default: 0
    	t.string :series
    	# t.string :group
    	# t.string :publisher
    	t.boolean :draft, default: false
    	t.boolean :featured, default: false

        t.belongs_to :admin_user, index:true

      t.timestamps null: false
    end
  end
end
