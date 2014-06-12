# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick support:
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "posts/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # the method we will be using to handle the uploaded vectors
  def convert_to_png
    manipulate! do |img|
      img.format("png") do |cmd|
        cmd.background "transparent"
        cmd.colorspace "sRGB"
      end
      img = yield(img) if block_given?
      img
    end
  end

  # define how we will create the thumbnail
  def resize_thumb
    manipulate! do |img|
      img.format("png") do |cmd|  # for some reason, it won't process properly eithout specifying the format to PNG, don't remove this!
        cmd.resize "400x400"
      end
      img = yield(img) if block_given?
      img
    end
  end

  def md5
    chunk = model.send(mounted_as)
    @md5 ||= Digest::MD5.hexdigest(chunk.read.to_s)
  end

  # Create png version
  version :png do
    process :convert_to_png
    def full_filename (for_file = file)
      "png_#{@md5}.png"
    end
  end

  # Create thumbnail version
  version :thumb, :from_version => :png do
    process :resize_thumb
    def full_filename (for_file = file)
      "th_#{@md5}.png"
    end
  end

  # Add a white list of extensions which are allowed to be uploaded.
  def extension_white_list
    %w(svg)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if original_filename
      @name ||= Digest::MD5.hexdigest(File.dirname(current_path))
      "#{@name}.#{file.extension}"
    end
  end

end
