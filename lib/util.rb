require 'erb'
require 'date'
require 'wareki'

module Util
  def load_as_erb(file_path)
    ERB.new(File.read(file_path)).result(binding)
  end

  def resize_image_opt(img, w, h)
    w_ori = img[:width].to_f
    h_ori = img[:height].to_f
    w_f = w.to_f
    h_f = h.to_f
    w_tar = w_ori
    h_tar = h_ori

    len_max = [w_tar, h_tar].min
    if w_tar > h_tar
      h_tar = len_max
      w_tar = len_max * w_f / h_f
    else
      h_tar = len_max * h_f / w_f
      w_tar = len_max
    end
    "#{w_tar.to_i}x#{h_tar.to_i}+0+0!"
  end

end
