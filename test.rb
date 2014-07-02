require './lib/html/patterns'
require './lib/converter/htmltomd'

patterns = HTML::Patterns.new

hmd = CONVERTER::HtmlToMd.new("../../FileOut.html")

preTagReg = /<(ul|ol|)\b[^>]*>([\s\S]*)<\/|ul|ol>/

match = preTagReg.match("<ol><li>asd</li><li>asd</li></ol>")

hmd.readHtmlFile()
#hmd.showRawContent()
hmd.convert()
