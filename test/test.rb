Dir["../lib/converter/*.rb"].each {|file| require file }

hmd = CONVERTER::HtmlToMd.new("FileOut.html")

hmd.convert()
