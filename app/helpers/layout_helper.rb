module LayoutHelper

  def sass_include(path)
    stylesheet_link_tag(path)
  end

  def top_line
    @top_line || 'Welcome to CollEDGE!'
  end

  def set_top_line(text)
    @top_line = text
  end

  def standard_flash_box
    content_tag(:div, flash[:notice], :class => 'flash_messages') if flash[:notice].present?
  end

  def include_css(path)
    content_for :stylesheets, sass_include(path)
  end
end