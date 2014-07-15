require_relative "../html/patterns.rb"

module CONVERTER

  ##
  # This class handle the html2md part
  
  class HtmlToMd

    ##
    # Initialize a few instance variables before we start
    
    def initialize(htmlFile)
      @html_file      = htmlFile
      @html_content   = nil
      @md_output      = nil
      @patterns       = HTML::Patterns.new
    end

    ##
    # Show the raw content of the html file
    # if the content isn't set, we'll set it

    def raw_content
      @html_content ||= File.read(@html_file)
    end

    def convert
      @md_output ||= @patterns.tags.values.inject(raw_content) do |result, element|
        element.call(result)
      end
    end
    
    private 
    
      #TODO output the converted content into a .md instead of showing it
      
      #puts @htmlContent
  end 
end