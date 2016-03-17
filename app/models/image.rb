class Image < ActiveRecord::Base
 belongs_to :gallery
  has_attached_file :image
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  
  def as_preview(object)
    # binding.pry
    object.update(image: self)
  end
end


