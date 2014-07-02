module HTML
	class Patterns  	
    def initialize()
  	 #base html tags with their replacements lambda
      @tags = {
        
        :h1      => lambda {|htmlContent|
          htmlContent.gsub!(/<h1\b[^>]*>/, "#")
          htmlContent.gsub!( /<\/h1>/, "")
        },
        :h2      => lambda { |htmlContent|
          htmlContent.gsub!(/<h2\b[^>]*>/, "##")
          htmlContent.gsub!( /<\/h2>/, "")
        },
        :h3      => lambda { |htmlContent| 
        	htmlContent.gsub!(/<h3\b[^>]*>/, "###")
          htmlContent.gsub!( /<\/h3>/, "")
        },
        :h4      => lambda { |htmlContent| 
        	htmlContent.gsub!(/<h4\b[^>]*>/, "####")
          htmlContent.gsub!( /<\/h4>/, "")
        },
        :h5      => lambda { |htmlContent| 
        	htmlContent.gsub!(/<h5\b[^>]*>/, "#####")
          htmlContent.gsub!( /<\/h5>/, "")
        },
        :h6      => lambda { |htmlContent| 
        	htmlContent.gsub!(/<h6\b[^>]*>/, "######")
          htmlContent.gsub!( /<\/h6>/, "")
        },
        :i       => lambda { |htmlContent| 
        	htmlContent.gsub!(/<i\b[^>]*>/, "_")
          htmlContent.gsub!( /<\/i>/, "_")
        },
        :em      => lambda { |htmlContent| 
        	htmlContent.gsub!(/<em\b[^>]*>/, "_")
          htmlContent.gsub!( /<\/em>/, "_")
        },
        :b       => lambda { |htmlContent| 
        	htmlContent.gsub!(/<b\b[^>]*>/, "**")
          htmlContent.gsub!( /<\/b>/, "**")
        },
        :strong  => lambda { |htmlContent| 
        	htmlContent.gsub!(/<strong\b[^>]*>/, "**")
          htmlContent.gsub!( /<\/strong>/, "**")
        },
        :strike  => lambda {|htmlContent| 
        	htmlContent.gsub!(/<strike\b[^>]*>/, "~~")
          htmlContent.gsub!( /<\/strike>/, "~~")
        },
        :br      => lambda { |htmlContent| 
        	htmlContent.gsub!(/<br\b[^>]*>/, "\n")
          htmlContent.gsub!(/<\/br>/, "\n")
        },
        :hr      => lambda { |htmlContent| 
        	htmlContent.gsub!(/<hr\b[^>]*>/, "\n * * * \n")
          htmlContent.gsub!(/<\/hr>/, "\n * * * \n")
        },
        :code    => lambda { |htmlContent| 
        	htmlContent.gsub!(/<code\b[^>]*>/, "`")
          htmlContent.gsub!(/<\/code>/, "`")
        },
        :p       => lambda { |htmlContent| 
        	htmlContent.gsub!(/<p\b[^>]*>/, "\n")
          htmlContent.gsub!(/<\/p>/, "\n")
        },
        :a       => lambda { |htmlContent|
          
          # will contain the elements to replace once we've dealed with the scan
          elementsToReplace = {}
        
          # groupe 1 => the <a href></a>  itself
          # groupe 2 => href value 
          # groupe 3 => text
          aElementReg = /(<a\s+(?:[^>]*?\s+)?href="([^"]*)">([\s\S]*?)<\/a>)/
          
          #Loop trough all the matches
          htmlContent.scan(aElementReg) {|pattern|
            # Build the hashmap of string => array
          	elementsToReplace[pattern[0]] = [pattern[2], pattern[1]]
          }
        
          #Loop trough all the elements to replace
          elementsToReplace.each do |rawElement, values|
          	htmlContent.gsub!(rawElement, "[#{values[0]}](#{values[1]})")
      		end
        },
        :img     => lambda { |htmlContent|
          
          # this one ain't gonna be pretty sorry !
          #" ![](./pic/pic1s.png =250x)
          #<\s*img\s*alt="?(.*?)"?\s*src="?(.*?)"?\s*width="?(.*?)"?\s*height="?(.*?)"?\s*\/?>
          #(<img\s+[^>]*src="([^"]*)"[^>]*>)
          
          srcReg = /(<img\s+[^>]*src="([^"]*)"[^>]*>)/
          altReg = /(<img\s+[^>]*alt="([^"]*)"[^>]*>)/
          
          # will contain the elements to replace once we've dealed with the scan
          elementsToReplace = {}
          
          # The reason i'm doing 2 .scan with 2 different regex, is because i can't
          # predict the order of the tags when the end user write his html :(
          # and i'm to lazy for another solution at the moment...have mercy on my soul
          
          #Loop trough all the matches for the SRC
          htmlContent.scan(srcReg) {|pattern|
            	elementsToReplace[pattern[0]] = [pattern[1]]
          }
          
          #Loop trough all the matches for the ALT
          htmlContent.scan(altReg) {|pattern|
            	elementsToReplace[pattern[0]].push(pattern[1])
          }
          
          # TODO ADD THE WIDTH ATTRIBUTE
          
          #Loop trough all the elements to replace
          elementsToReplace.each do |rawElement, values|
          	htmlContent.gsub!(rawElement, "![#{values[0]}](#{values[1]})")
        	end
      	}
      }
      
      # TODO parse these fuckers
      @specialTags = ["ul", "li", "ol"]
    end
  
    def getTags()
      return @tags
    end   
	end
end