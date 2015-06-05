class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
    	t.string :title
    	t.text :description
    	t.string :language
    	t.integer :downloads, default: 0
    	t.integer :plays, default: 0
    	t.string :series
    	t.string :group
    	t.string :publisher
    	t.boolean :draft, default: false

      t.timestamps null: false
    end
  end
end
