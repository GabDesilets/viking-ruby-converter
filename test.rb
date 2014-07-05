require './lib/html/patterns'
require './lib/converter/htmltomd'

patterns = HTML::Patterns.new

hmd = CONVERTER::HtmlToMd.new("../../FileOut.html")

hmd.convert()
