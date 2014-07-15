#!/usr/bin/env ruby
Dir["../lib/converter/*.rb"].each {|file| require file}

hmd = CONVERTER::HtmlToMd.new("FileOut.html")

p hmd.convert()