class Image < ActiveRecord::Base
 belongs_to :gallery
  has_attached_file :image,
        :styles => { :medium => "x300", :thumb => "x100" },
        :default_url => ':s3_domain_url',
        :storage => :s3,
        :bucket => 'teamdrivedigitalshop',
        :s3_credentials => {
    		:bucket => ENV['AWS_BUCKET'],
    		:access_key_id => ENV['AWS_ACCESS_KEY_ID'],
    		:secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
  			},
            :url => "/:image/:id/:style/:basename.:extension",
            :path => ":image/:id/:style/:basename.:extension"
   validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def as_preview(object)
    object.update(image: image)
  end
end
