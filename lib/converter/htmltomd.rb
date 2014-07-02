require './lib/html/patterns'

module CONVERTER
	class HtmlToMd
	  
		
    def initialize(htmlFile)
		  @htmlFile      = htmlFile
	  	@htmlContent   = nil
	  	@outputContent = ""
	  	@outputDir     = nil
	  	@patterns      = HTML::Patterns.new
    end
	
    def readHtmlFile()
  		if ! @htmlFile.nil?
      	@htmlContent = File.open(@htmlFile, "rb").read
    	end
    end

    def showRawContent()
    	puts @htmlContent
    end

    def convert
		  if ! @htmlContent.nil?
        doConvertion()
    	else
      	return nil
    	end
    end
    
    def doConvertion()
		  @patterns.getTags.each do |htmlTag, replacement|
      	replacement.call(@htmlContent)
		  end
		  puts @htmlContent
    end   
	end
end
