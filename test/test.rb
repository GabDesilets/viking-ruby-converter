#!/usr/bin/env ruby
require 'minitest/autorun'
Dir["../lib/converter/*.rb"].each {|file| require file}

hmd = CONVERTER::HtmlToMd.new(File.read("FileOut.html"))

p hmd.markdown