#!/usr/bin/env ruby
require 'minitest/autorun'
Dir["../lib/converter/*.rb"].each {|file| require file}

class TestHTMLToMd < Minitest::Test
	def setup
		@hmd = CONVERTER::HtmlToMd.new("")
	end

	def test_converts_h3
		@hmd.html = "<h3>Hello</h3>"
		assert_equal "###Hello", @hmd.markdown
	end

	def test_converts_italics
		@hmd.html = "<i>Foobar</i>"
		assert_equal "_Foobar_", @hmd.markdown
	end

	def test_converts_a_link
		#TODO
	end
end