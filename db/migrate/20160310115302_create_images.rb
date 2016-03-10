class CreateImages < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
			t.references :galleryable, index: true, polymorphic: true
      t.timestamps null: false
    end
  end
end
