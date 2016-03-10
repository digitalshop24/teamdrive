class CreateGalleryables < ActiveRecord::Migration
  def change
    create_table :galleryables do |t|

      t.timestamps null: false
    end
  end
end
