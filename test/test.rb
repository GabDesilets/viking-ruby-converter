require 'minitest/autorun'
require 'viking'

class TestHTMLToMd < Minitest::Test
	def setup
		@hmd = Viking::Converters::HtmlToMd.new("")
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