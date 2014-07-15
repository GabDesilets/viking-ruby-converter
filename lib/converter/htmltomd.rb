require_relative "../html/patterns.rb"

module CONVERTER

  ##
  # This class handle the html2md part
  
  class HtmlToMd
    attr_accessor :html
    ##
    # Initialize a few instance variables before we start
    
    def initialize(html)
      @html           = html
      @markdown = nil
      @patterns       = HTML::Patterns.new
    end

    def markdown
      @markdown ||= @patterns.tags.values.inject(@html) do |result, element|
        element.call(result)
      end
      puts @md_output
    end
    
    private 
    
      #TODO output the converted content into a .md instead of showing it
      
  end 
end