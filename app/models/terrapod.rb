class Terrapod < ActiveRecord::Base
  has_attached_file :preview
  validates_attachment_content_type :preview, content_type: /\Aimage\/.*\Z/
 belongs_to :image
  include Galleryable
  has_one :gallery, as: :galleryable, dependent: :destroy
 
  after_save :set_preview

  def set_preview
    if !image && images
      images.first.as_preview(self)
      # update(image: images.first)
    #   images.first.as_preview(self) if images
    end
  end
end
