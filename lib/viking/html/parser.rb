module Viking
	module HTML
		class Parser
			def initialize(content)
				@t = Tokenizer.new(content)
				@root = Node.new(nil)
			end

			def parse
				current_node = @root

				@t.each do |token|
					case token
					when /(<\s*\/[^>]>)/ # close tag
						current_node.children.push EndNode.new($1, current_node)
					when /(<\s*[^>|^\s]\s*>)/ # open tag
						current_node.children.push StartNode.new($1, current_node)
						current_node = current_node.children.last
					else # something else (presumably text)
						current_node.children.push TextNode.new(token, current_node)
					end
				end
				self # return self to chain calls?
			end
		end
	end
end