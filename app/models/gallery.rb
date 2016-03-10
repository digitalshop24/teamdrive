class Gallery < ActiveRecord::Base
	belongs_to :galleryable
	has_many :images, dependent: :destroy

	def images=(array)
		array.each do |file|
			images.create(image: file)
		end
	end
end
