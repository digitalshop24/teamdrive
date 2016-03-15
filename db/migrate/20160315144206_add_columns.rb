class AddColumns < ActiveRecord::Migration
  def change
  	add_column :articles, :image_id, :string
  	add_column :grounds, :image_id, :string
  	add_column :news, :image_id, :string
  	add_column :terrapods, :image_id, :string
  end
end
