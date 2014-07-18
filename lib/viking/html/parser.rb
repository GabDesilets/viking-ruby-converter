module Viking
	module HTML
		class Parser
			attr_accessor :root

			def initialize(content)
				@t = Tokenizer.new(content)
				@root = Node.new(nil, nil)
			end

			def parse
				current_node = @root

				@t.each do |token|
					case token
					when /\// # close tag
						current_node.children.push EndNode.new(token, current_node)
						# TODO:
						# THEORETICALLY SPEAKING, this should verify that this close tag name matches
						# the name of the last open node, and throw a parse error if it does not.
						current_node = current_node.parent
					when /(<[\s]*[^>|\/]+[\s]*>)/ # open tag
						current_node.children.push StartNode.new(token, current_node)
						current_node = current_node.children.last
					else # something else (presumably text)
						current_node.children.push TextNode.new(token, current_node) { |n| n.name = :text }
					end
				end
				self # return self to chain calls?
			end
		end
	end
end