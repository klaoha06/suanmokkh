class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.date :date
      # t.string :language
      t.text :external_cover_img_link

      t.timestamps null: false
    end
  end
end
