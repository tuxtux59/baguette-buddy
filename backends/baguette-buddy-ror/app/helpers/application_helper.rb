require 'mini_magick'

module ApplicationHelper
  def optimize_illustration(src_path)
    image = MiniMagick::Image.open(src_path)
    logger.debug "optimizing illustration..."
    logger.debug "from #{image.width}x#{image.height}"
    
    max_dimension = 800
    image.resize "#{max_dimension}x#{max_dimension}>"
    image.quality "85"
    image.format "png"
    logger.debug "to #{image.width}x#{image.height}"
    return image.to_blob
  end
end
