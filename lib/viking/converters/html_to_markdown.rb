module Viking
  module Converters
  ##
  # This class handle the html2md part
  
  class HtmlToMd
    attr_accessor :html
    
    def initialize(html)
      @html           = html
      @markdown       = nil
      @patterns       = Viking::Patterns.new
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
      #I suggest this is the job of the caller - the class is more flexible if it just outputs a string.
      # That string can then be written to a file...or the network, or embedded in a template...etc
      
    end 
  end
end