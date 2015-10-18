class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :retreat_talk_id
      t.integer :related_retreat_talk_id

      t.timestamps null: false
    end
  end
end
