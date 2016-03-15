class Ckeditor::AttachmentFile < Ckeditor::Asset
  has_attached_file :data,
    styles: { thumb: "200x200>", medium: "700x500>", big: "1000x1000>" }, 
    :convert_options => { :medium => '-quality 70 -strip' }, 
    :path => '/:class/:attachment/:id_partition/:style/:filename',
    :url  => ":s3_eu_url",
    :s3_credentials => "#{Rails.root.to_s}/config/aws.yml"
  
  Paperclip.interpolates(:s3_eu_url) { |attachment, style|
  "#{attachment.s3_protocol}://s3-eu-central-1.amazonaws.com/#{attachment.bucket_name}/#{attachment.path(style).gsub(%r{^/}, "")}"
  }
  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_content_type :data, :content_type => /\Aimage/

  def url_thumb
    @url_thumb ||= Ckeditor::Utils.filethumb(filename)
  end
end
