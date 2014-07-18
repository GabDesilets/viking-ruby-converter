require 'minitest/autorun'
require 'viking'

  ##
  # Class
  # @author Aaron(BinaryPaean)
  # Tests for the (crude) HTML Tokenizer
  #
  
class TestNode < Minitest::Test

  def test_with_flags
    @n = Viking::HTML::StartNode.new("<a href=\"foobar\" id = myid class='somedumclass'>", nil)
    assert_equal "foobar", @n.flags[:href] 
    assert_equal :a, @n.name
    assert_equal "myid", @n.flags[:id]
    assert_equal "somedumclass", @n.flags[:class]
  end   

  def test_end_node
    @n = Viking::HTML::EndNode.new("< /a >", nil)
    assert_equal :a, @n.name
  end

end
