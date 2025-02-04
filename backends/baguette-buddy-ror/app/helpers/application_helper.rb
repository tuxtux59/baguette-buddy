require 'mini_magick'

module ApplicationHelper
  def optimize_illustration(src_path)
    image = MiniMagick::Image.open(src_path)
    
    max_dimension = 800
    image.resize "#{max_dimension}x#{max_dimension}>"
    image.quality "85"
    image.format "png"
    
    return image.to_blob
  end
end
