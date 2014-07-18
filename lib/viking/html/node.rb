module Viking
	module HTML
		require 'strscan'

		class Node
			attr_accessor :children, :name, :content

			def initialize(content, parent)
				@parent = parent
				@content = content
				@children = []
				@name = nil
				yield self if block_given?
			end

			def to_s
				@children.join()
			end
		end

		class StartNode < Node
			attr_reader :flags
			def initialize (content, parent)
				@flags = {}
				super content, parent
				parse_flags(parse_name(@content))
			end

			private

			def parse_flags(content)
				s = StringScanner.new(content)
				s.skip(/^</)# skip the initial tag delimeter
				while s.exist?(/\s*(\w+)\s*=/)
					begin
						#TODO there are valid flags in HTML5 which omit the =
						flag = s.scan(/\s*(\w+)\s*=/).gsub(/[=|\s]/,'').to_sym  #chop off the = from the flag name
						@flags[flag] = s.scan(/[\s]*(['|"]?)[\s]*([\w]+)[\s]*(\1)[\s]*/).gsub(/[\s'"]/,'')
					rescue
						raise "Parse error at: #{@content}"
					end
				end
			end

			def parse_name(content)
				s = StringScanner.new(content)
				s.skip(/^</)# skip the initial tag delimeter
				@name = s.scan(/\s*(\w+)\s*/).gsub(/\s/,'').to_sym
				s.rest
			end
		end

		class EndNode < Node
			def initialize(content, parent)
				super content, parent
				parse_name @content
			end

			private

			def parse_name(content)
				s = StringScanner.new(content)
				s.skip(/^<\s*\//)# skip the initial tag delimeter
				@name = s.scan(/\s*(\w+)\s*/).gsub(/\s/,'').to_sym
			end
		end
	end
end