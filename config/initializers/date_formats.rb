DATE_FORMATS = ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS
TIME_FORMATS = ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS
DATE_FORMATS.merge!( :event_date_display   => "%a, %b %e, %Y")      # e.g. Wed, Jan 20, 2010
DATE_FORMATS.merge!( :slash                => "%m/%d/%Y")           # e.g. 01/20/2010
DATE_FORMATS.merge!( :human_short          => "%b %d, %Y" )         # e.g. Jan 20, 2010
DATE_FORMATS.merge!( :human_short_underbar => "%b_%d_%Y" )          # e.g. Jan_20_2010
DATE_FORMATS.merge!( :real_short           => "%B %e" )             # e.g. January 20

TIME_FORMATS.merge!( :slash_time           => "%m/%d/%Y %I:%M%p" )  # e.g. 01/20/2010 10:21AM
TIME_FORMATS.merge!( :alert                => "%I:%M%p %Z %b %d" )  # e.g. 10:21AM EST Jan 20
TIME_FORMATS.merge!( :pub_time             => "%B %e" )             # e.g. January 20

# e.g. Wednesday, January 20th, 2010
DATE_FORMATS.merge!( :full => lambda { |date| date.strftime("%A, %B #{date.day.ordinalize}, %Y") } )

# e.g. Wednesday, January 20th, 2010 at 10:21 AM EST
TIME_FORMATS.merge!( :full_datetime => lambda { |time| time.strftime("%A, %B #{time.day.ordinalize}, %Y at %l:%M %p %Z") } )

# CalendarDateSelect::FORMATS[:punch] = {
# # Here's the code to pass to Date#strftime
#   :date => "%a, %b %e, %Y",
#   :time => " %I:%M %p",  # notice the space before time.  If you want date and time to be seperated with a space, put the leading space here.
# 
#   :javascript_include => "calendar_date_select_format_punch"
# }
# CalendarDateSelect.format = :punch