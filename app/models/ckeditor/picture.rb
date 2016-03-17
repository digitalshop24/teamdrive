class Ckeditor::Picture < Ckeditor::Asset
 has_attached_file :data
  validates_attachment_presence :data
  validates_attachment_size :data, :less_than => 2.megabytes
  validates_attachment_content_type :data, :content_type => /\Aimage/
end
