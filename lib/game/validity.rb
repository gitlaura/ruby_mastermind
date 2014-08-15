module Validity

	COLORS = ["R", "Y", "G", "B", "P", "O"]

	def valid_interface?(selection)
		if selection == 1 || selection == 2
			return true
		end
		false
	end

	def valid_player?(selection)
		if selection == 1 || selection == 2
			return true
		end
		false
	end

	def valid_combination?(input)
		if input.length != 4
			return false
		else
			input.upcase.each_char do |color|
				return false if !(COLORS.include?(color))
			end
		end
		true
	end
end