module Validity
	def valid_interface?(selection)
		if selection != 1 && selection != 2
			return false
		end
		true
	end

	def valid_player?(selection)
		if selection != 1 && selection != 2
			return false
		end
		true
	end

	def valid_combination?(input)
		if input.length != 4
			return false
		elsif
			input.upcase.each_char do |color|
				return false if !(color =~ /[RYPOBG]/)
			end
		end
		true
	end
end