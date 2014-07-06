require './lib/html/patterns'

module CONVERTER
  
  ##
  # This class handle the html2md part
  
  class HtmlToMd
    
    ##
    # Initialize a few instance variables before we start
    
    def initialize(htmlFile)
      @htmlFile      = htmlFile
      @htmlContent   = nil
      @patterns      = HTML::Patterns.new
    end
  
    ##
    # Show the raw content of the html file
    # if the content isn't set, we'll call the set methode

    def showRawContent()
      if ! @htmlContent.nil?
        setHtmlContent()
      end
      puts @htmlContent
    end

    ##
    # Call the convertion methode
    # call set methode for the html content if it's not setted
    
    def convert
      if @htmlContent.nil?
        setHtmlContent()
      end
      doConvertion()
    end
    
    private 
    
    ##
    # Set the html content if it wasn't already set
    
    def setHtmlContent()
      if ! @htmlFile.nil?
        @htmlContent = File.open(@htmlFile, "rb").read
      end
    end

    ##
    # Iterate through all the tags we setted in our patterns class
    # and call their replacement method
    
    def doConvertion()
      @patterns.getTags.each do |htmlTag, replacement|
        replacement.call(@htmlContent)
      end
      
      #TODO output the converted content into a .md instead of showing it
      
      #puts @htmlContent
    end 
      
  end
end
