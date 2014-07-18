require 'minitest/autorun'
require 'viking'

  ##
  # Class
  # @author Aaron(BinaryPaean)
  # Tests for the (crude) HTML Tokenizer
  #
  
class TestHTMLTokenizer < Minitest::Test

  def test_linear_tags
    @t = Viking::HTML::Tokenizer.new("Some Text <i>with italics</i>.")
      assert_equal "Some Text ", @t.next
      assert_equal "<i>", @t.next
      assert_equal "with italics", @t.next
      assert_equal "</i>", @t.next
      assert_equal ".", @t.next
      assert_equal nil, @t.next
  end   

  def test_nested_tags
    @t = Viking::HTML::Tokenizer.new("<h1>Everybody <b>Knows</b> the Dice are Loaded.</h1>")
    ["<h1>", "Everybody ", "<b>", "Knows", "</b>"," the Dice are Loaded.","</h1>"].each do |tag|
      assert_equal tag, @t.next
    end
  end

  def test_to_a
    @t = Viking::HTML::Tokenizer.new("<h1>Everybody <b>Knows</b> the Dice are Loaded.</h1>")
    a = @t.to_a
    assert_equal ["<h1>", "Everybody ", "<b>", "Knows", "</b>"," the Dice are Loaded.","</h1>"], a
  end

  def test_flags
    @t = Viking::HTML::Tokenizer.new("<h1 id = 'this' class=\"that\">Everybody <b>Knows</b> the Dice are Loaded.</h1>")
    ["<h1 id = 'this' class=\"that\">", "Everybody ", "<b>", "Knows", "</b>"," the Dice are Loaded.","</h1>"].each do |tag|
      assert_equal tag, @t.next
    end
  end

end
