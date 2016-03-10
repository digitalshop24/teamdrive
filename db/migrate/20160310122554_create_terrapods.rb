class CreateTerrapods < ActiveRecord::Migration
  def change
    create_table :terrapods do |t|
			t.string :title
			t.text :body
			t.integer :price
			t.attachment :image
      t.timestamps null: false
    end
  end
end
