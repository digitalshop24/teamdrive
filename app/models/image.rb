class Image < ActiveRecord::Base
 belongs_to :gallery
  has_attached_file :image,
    styles: { thumb: "200x200>", medium: "700x500>", big: "1000x1000>" }, :convert_options => { :medium => '-quality 70 -strip' }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def as_preview(object)
    object.update(image: image)
  end
end
