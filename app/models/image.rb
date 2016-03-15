class Image < ActiveRecord::Base
 belongs_to :gallery
  has_attached_file :image,
    styles: { thumb: "200x200>", medium: "700x500>", big: "1000x1000>" }, 
    :convert_options => { :medium => '-quality 70 -strip' }, 
    :path => '/:class/:attachment/:id_partition/:style/:filename',
    :url  => ":s3_eu_url"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  Paperclip.interpolates(:s3_eu_url) { |attachment, style|
  "#{attachment.s3_protocol}://s3-eu-central-1.amazonaws.com/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/}, "")}"
  }
  
  def as_preview(object)
    object.update(image: image)
  end
end


