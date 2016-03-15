class AddFieldToColumns < ActiveRecord::Migration
  def change
  	add_column :events, :image_id, :string
  end
end
