class Gallery < ActiveRecord::Base
	belongs_to :galleryable
	belongs_to :image
	has_many :images, dependent: :destroy

	def images=(array)
		array.each do |file|
			images.build(image: file)
			save
		end
	end
end
