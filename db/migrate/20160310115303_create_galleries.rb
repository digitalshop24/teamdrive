class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :images do |t|
			t.attachment :image
			t.references :gallery, index: true, foreign_key: true
      t.timestamps null: false
    end
	end
end
