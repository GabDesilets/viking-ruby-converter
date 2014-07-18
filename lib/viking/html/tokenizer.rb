module Viking
	module HTML
		require 'strscan'
		class Tokenizer
			def initialize(string)
				@s = StringScanner.new(string)
			end

			def next
				unless @s.match?(/</)
					@s.scan(/[^<]+/)
				else
					@s.scan(/[^>]+>/)
				end
			end

			def each
				until @s.eos?
					yield self.next
				end
			end

			def to_a
				a = []
				self.each {|t| a.push t}
				a
			end
		end
	end
end