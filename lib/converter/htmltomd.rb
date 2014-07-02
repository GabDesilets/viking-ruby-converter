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
        #doConvertion()
        doConvertion2()
      else
        return nil
      end
    end

    def doConvertion()

      @patterns.getTags.each do |htmlTag, mdTag|

        #regex that extract every explicit tag and it's content
        tagReg = /<(#{htmlTag})\b[^>]*>([\s\S]*?)<\/#{htmlTag}>/
        reg    = /<(#{htmlTag})\b[^>]*>/

          #Loop trough all the matches for our regex from our html file
          @htmlContent.scan(tagReg) {|pattern| 

          puts "patterns => #{pattern[0]}  string => #{pattern[1]} \n" 
          rawTag = @patterns.getMdTag(pattern[0].to_sym)

          #<a> TAG
          if pattern[0].to_sym == :a

            aTagReg = /<a\s+(?:[^>]*?\s+)?href="([^"]*)/
            aMatch = aTagReg.match(@htmlContent)
            if aMatch
              theTag = "[#{pattern[1]}](#{aMatch[1]})"
            end
          else
            #Everything else for the moment
            theTag = rawTag.to_s.sub("{{TEXT}}", pattern[1])
          end

          #theTag = rawTag.to_s.sub("{{TEXT}}", pattern[1])
          @outputContent << "#{theTag} \n"
        }
      end 
      puts @outputContent 
    end   

    def doConvertion2()

		@patterns.getTags.each do |htmlTag, replacement|
		 	#regex that extract every explicit tag and it's content
        	#tagReg = /<(#{htmlTag})\b[^>]*>([\s\S]*?)<\/#{htmlTag}>/
        	
        	replacement.call(@htmlContent)
		end
		puts @htmlContent
    end   

  end
end
