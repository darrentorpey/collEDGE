module Compass::SassExtensions::Functions
end

module Sass::Script::Functions
  def reverse(string)
    assert_type string, :String
    Sass::Script::String.new(string.value.reverse)
  end

  def blend(one_color, other_color, percent = Sass::Script::Number.new(50))
    assert_type one_color, :Color
    assert_type other_color, :Color
    assert_type percent, :Number
    blended = (one_color.div(Sass::Script::Number.new(100).div(percent))).plus((other_color).div(Sass::Script::Number.new(100).div(Sass::Script::Number.new(100).minus(percent))))
    Sass::Script::Color.new(blended.value)
  end
end

['selectors', 'enumerate', 'urls', 'display', 'inline_image'].each do |func|
  require File.join(File.dirname(__FILE__), 'functions', func)
end

module Sass::Script::Functions
  include Compass::SassExtensions::Functions::Selectors
  include Compass::SassExtensions::Functions::Enumerate
  include Compass::SassExtensions::Functions::Urls
  include Compass::SassExtensions::Functions::Display
  include Compass::SassExtensions::Functions::InlineImage
end

# Wierd that this has to be re-included to pick up sub-modules. Ruby bug?
class Sass::Script::Functions::EvaluationContext
  include Sass::Script::Functions
end