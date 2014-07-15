require_relative "../html/patterns.rb"

module CONVERTER

  ##
  # This class handle the html2md part
  
  class HtmlToMd
    attr_accessor :html
    
    def initialize(html)
      @html           = html
      @markdown       = nil
      @patterns       = HTML::Patterns.new
    end

    def markdown
      @markdown ||= @patterns.tags.inject(@html) {|result, element| element.call(result)}
    end

    def html= html
      @html = html
      @markdown = nil
      self
    end
    
    private 
    
      #TODO output the converted content into a .md instead of showing it
      
  end 
end