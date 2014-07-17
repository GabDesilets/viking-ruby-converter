module Viking
  
  ##
  # Class
  # @author Gabriel Désilets(bestdramana)
  # This class handle the patterns and their replacements
  
  class Patterns    
    
    ##
    # Initialize the tags and their replacements
    def initialize()
      @tags = []
      [
        ["h1", "#", ""],
        ["h2", "##", ""],
        ["h3", "###", ""],
        ["h4", "####", ""],
        ["h5", "#####", ""],
        ["h6", "######", ""],
        ["i(?!mg)", "_", "_"],# img tag was entering here before - Gabriel(bestdramana)
        ["em", "_", "_"],
        ["b(?!r)", "**", "**"],# br tag was entering here before - Gabriel(bestdramana)
        ["strong", "**", "**"],
        ["strike", "~~", "~~"],
        ["br", $/, $/],
        ["hr", "* * *", "* * *"],
        ["code", "`", "`"],
        ["p", $/, $/],
        ].each do |value|
          @tags.push simple_tag_matcher(value[0],value[1],value[2])
        end

        @tags.push lambda{|htmlContent|
          
          # will contain the elements to replace once we've dealed with the scan
          elementsToReplace = {}
        
          # groupe 1 => the <a href></a>  itself
          # groupe 2 => href value 
          # groupe 3 => text
          aElementReg = /(<a\s+(?:[^>]*?\s+)?href=(?:'|")([^"]*)(?:'|")>([\s\S]*?)<\/a>)/
          
          #Loop trough all the matches
          htmlContent.scan(aElementReg){|pattern|
            # Build the hashmap of string => array
            elementsToReplace[pattern[0]] = [pattern[2], pattern[1]]
          }
        
          #Loop trough all the elements to replace
          elementsToReplace.each do |rawElement, values|
            htmlContent.gsub!(rawElement, "[#{values[0]}](#{values[1]})")
          end
          htmlContent
        }

        @tags.push lambda{|htmlContent|
           
          # will contain the elements to replace once we've dealed with the scan
          elementsToReplace = {}
          
          # TODO ADD THE WIDTH ATTRIBUTE
         
          # I've changed the way i was doing it, i think it's better this way. 
          # Instead of writing the code 3 time - Gabriel(bestdramana)
          ["src", "alt", "width", "height"].each{|tag|
            tag_regex = Regexp.new("(<img.+?#{tag}=[\"'](.+?)[\"'].*?>)")
            #Loop trough all the matches for the tag
            htmlContent.scan(tag_regex) {|pattern|
              elementsToReplace.key?(pattern[0]) \
              ? elementsToReplace[pattern[0]].push(pattern[1]) \
              : elementsToReplace[pattern[0]] = [pattern[1]]
            }
          }
              
          #Loop trough all the elements to replace
          elementsToReplace.each do |rawElement, values|
            replacement = "![#{values[1]}](#{values[0]}" 
            #Could and should be smarter... sorry brain fart - Gabriel(bestdramana)
            if values[2] && values[3]
              replacement += " =#{values[2]}x#{values[3]}"
            elsif values[2] && !values[3]
              replacement += " =#{values[2]}x"

            end
            replacement += ")"
            htmlContent.gsub!(rawElement, replacement)
          end
          htmlContent
        }
        @tags.push lambda{|htmlContent|replace_lists(htmlContent)}
    end
  
    def tags
      @tags
    end

    private 
    
    def simple_tag_matcher(tag, open_tag_replacement="", close_tag_replacement="")
      #puts "Tag => #{tag} close Replacement => #{close_tag_replacement}"
      open_tag_regex = Regexp.new("<\s*#{tag}[^>]*>")
      close_tag_regex = Regexp.new("<\s*\/#{tag}\s*>")
      return lambda{ |content|
        content.gsub(open_tag_regex, open_tag_replacement).gsub(close_tag_regex, close_tag_replacement)
      }
    end 

    def replace_lists(htmlContent) 
      ulolReg = /<(ul|ol)\b[^>]*>([\s\S]*?)<\/\1>/
      convertedEls = ""
      
      # will contain the elements to replace once we've dealed with the scan
      elementsToReplace = {}
          
      htmlContent.scan(ulolReg) {|pattern|
        lis = pattern[1].split('</li>')
        lis = lis[0, lis.length - 1]
        
        for i in 0..lis.length - 1
          if lis[i] then
            prefix = pattern[0] == "ol" ? "#{i+1}. " : "* "
            convertedEls = lis[i].sub(lis[i], "#{prefix}#{lis[i].match(/\s*<li[^>]*>([\s\S]*)/)[1]}\n")
            elementsToReplace[convertedEls] = lis[i]
          end
        end 
        #convertedEls << "\n"
      }
      
      #Loop trough all the elements to replace
      elementsToReplace.each do |value, rawElement|
        #puts rawElement
        htmlContent.gsub!(rawElement, value)
      end
      htmlContent.gsub!(/<ul\b[^>]*>|<ol\b[^>]*>/, "")
      htmlContent.gsub!(/<\/ul>|<\/ol>|<\/li>/, "")
      htmlContent
    end      
  end
end