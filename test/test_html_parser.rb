require 'minitest/autorun'
require 'viking'

  ##
  # Class
  # @author Aaron(BinaryPaean)
  # Tests for the (crude) HTML Tokenizer
  #
  
class TestHTMLParser < Minitest::Test

  def setup
    @p = Viking::HTML::Parser.new("<div class=\"yodawg\"><a href=\"foobar\" id = myid class='somedumclass'>foobar</a><b>to you too</b></div>")

    # root
    # | div
    # | | a 
    # | | | foobar
    # | | b
    # | | | to you too

  end

  def test_basic_structure
    @p.parse
    div = @p.root.children[0]
    assert_equal :div, div.name
    assert_equal "yodawg", div.flags[:class]
    a = div.children[0]
    assert_equal :a, a.name
    assert_equal "foobar", a.flags[:href]
    assert_equal "somedumclass", a.flags[:class]
    # AND NOW FOR THE MAGIC:
    puts ""
    puts "AND NOW FOR THE MAGIC"
    puts ""
    puts @p.root.to_s
  end

  def test_more_complicated_structure
    #TODO
  end
end
