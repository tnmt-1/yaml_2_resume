require 'erb'
require 'date'
require 'wareki'

module Util
  def load_as_erb(file_path)
    ERB.new(File.read(file_path)).result(binding)
  end

  def size(s, dpi = 75)
    if s =~ /\s*(\-?[0-9\.]+)\s*mm/
      $1.to_f / 25.4 * dpi
    elsif s =~ /\s*(-?[0-9\.]+)\s*cm/
      $1.to_f / 25.4 * dpi * 10
    elsif s =~ /\s*(-?[0-9\.]+)\s*px/
      $1.to_f
    else
      s.to_f
    end
  end

  def resize_image_opt(img, w, h)
    w_ori = img[:width].to_f
    h_ori = img[:height].to_f
    w_f = w.to_f
    h_f = h.to_f
    w_tar = w_ori
    h_tar = h_ori
    if (w_ori / h_ori) > (w_f / h_f)
      # wが長い
      w_tar = w_ori * w_f / h_f
    else
      # hが長い
      h_tar = h_ori * h_f / w_f
    end
    "#{w_tar.to_i}x#{h_tar.to_i}+0+0!"
  end

end
