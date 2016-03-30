class AddAttachmentToTerrapods < ActiveRecord::Migration
  def change
		add_attachment :terrapods, :preview	
  end
end
