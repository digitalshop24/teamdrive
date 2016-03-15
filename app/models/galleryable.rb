module Galleryable
	def images
		self.gallery.images if self.gallery
	end
	def images=(array)
		self.create_gallery unless self.gallery
		
		self.gallery.images = array
	end
end
