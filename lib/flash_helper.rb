# FlashHelper
module FlashHelper
  def display_flash
    ret = []
    flash.each do |key, value|
      ret << content_tag(:div, value, :id => "flash_#{key}")
    end
    return ret.join("\n")
end