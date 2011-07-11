# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support:
  include CarrierWave::RMagick
  # include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader:
  
  storage :s3

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  #def default_url
  #  "/images/fallback/"+version_name+"/dummy.jpg"
  #end
 
  # Process files as they are uploaded:
  # process :resize_to_fit => [550, 550]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
   version :thumb do
     process :resize_to_fit => [165, 220]
     process :convert => 'png'
     process :make_transparent
   end
   version :mini do
     process :resize_to_fit => [80, 80]
     process :convert => 'png'
   end
   version :big do
     process :resize_to_fit => [600, 800]
     process :convert => 'png'
   end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
     %w(jpg jpeg gif png)
   end
   
   def make_transparent 
     manipulate! do |img|
       image = Magick::Image.read(img.filename).first
       image.transparent("#ffffff", Magick::TransparentOpacity)
     end 
   end 
   
   def shadow
     manipulate! do |img|
       layers = Magick::ImageList.new
       image = Magick::Image.read(img.filename).first
       shadow = image.clone
       shadow = shadow.shadow(0, 0, 4.0, 0.5)
       shadow = shadow.colorize(1.0, 1.0, 1.0, 'gray25')
       layers << shadow << image
       result = layers.optimize_layers(Magick::MergeLayer)
     end
   end
   
   
   def filename
     super.chomp(File.extname(super)) + '.png'
   end

end
