require 'minitest/autorun'
require 'viking'

  ##
  # Class
  # @author Aaron(BinaryPaean)
  # This class handle the base unit test
  #
  # @change 2014-07-16 Gabriel(bestdramana)
  # @TODO IMG test case, lists test case and then cover some more ground with harder test
  # - Gabriel(bestdramana)
  
class TestHTMLToMd < Minitest::Test
  def setup
		@hmd = Viking::Converters::HtmlToMd.new("")
	end
	
  def test_converts_headers
    1.upto(6) do |i| 
      @hmd.html = "<h#{i}>Hello</h#{i}>"
      assert_equal "#{"#" * i}Hello", @hmd.markdown
    end   
  end

  def test_converts_italics
    ["<i>Foobar</i>", "<em>Foobar</em>"].each{|italicTag|
      @hmd.html =  italicTag
      assert_equal "_Foobar_", @hmd.markdown
    }
  end
	
  def test_converts_bolds
    ["<b>Do you even bold</b>", "<strong>Do you even bold</strong>"].each{|boldTag|
      @hmd.html =  boldTag
      assert_equal "**Do you even bold**", @hmd.markdown
    }
  end

  def test_converts_strike
    @hmd.html = "<strike>Not supported in HTML5</strike>"
    assert_equal "~~Not supported in HTML5~~", @hmd.markdown
  end
  
  def test_converts_break_line
    #in XHTML, the <br> tag must be properly closed, like this: <br />. - Gabriel(bestdramana)
    ["<br />", "<br/>", "<br>"].each{|breakTag|
      @hmd.html =  breakTag
      assert_equal $/, @hmd.markdown
    }
  end
  
  def test_converts_horizontal_line
    #in XHTML, the <hr> tag must be properly closed, like this: <hr />. - Gabriel(bestdramana)
    ["<hr />", "<hr/>", "<hr>"].each{|breakTag|
      @hmd.html =  breakTag
      assert_equal "* * *", @hmd.markdown
    }
  end
  
  def test_converts_code
    @hmd.html = "<code>$pistachio = 'on the patio';</code>"
    assert_equal "`$pistachio = 'on the patio';`", @hmd.markdown
  end
  
  def test_converts_paragraph
    @hmd.html = "<p>Thou shall not goto!</p>"
    assert_equal "#{$/}Thou shall not goto!#{$/}", @hmd.markdown
  end 
 
	def test_converts_a_link
		@hmd.html = "<a href='www.google.com'>test link</a>"
    assert_equal "[test link](www.google.com)", @hmd.markdown
	end
	
  
end