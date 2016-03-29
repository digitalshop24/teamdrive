class AddFieldToModels < ActiveRecord::Migration
  def change
  	add_column :articles, :video, :string
  	add_column :events, :video, :string
  	add_column :grounds, :video, :string
  	add_column :news, :video, :string
  	add_column :terrapods, :video, :string
	end
end
