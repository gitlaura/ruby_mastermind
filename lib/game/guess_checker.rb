class GuessChecker
	attr_accessor :black, :white, :temp_code, :temp_guess

	def check_guess(guess, code, colors)
		saved_guess = guess.to_sym
		saved_code = code.to_sym
		@temp_guess, @temp_code = saved_guess.to_s, saved_code.to_s
		@black = count_black_pegs
		@white = count_white_pegs(colors)
	end

	def count_black_pegs
		black = 0
		(0..3).each do |index|
			if @temp_code[index] == @temp_guess[index]
				black += 1
				@temp_code[index] = no_longer_valid_color
				@temp_guess[index] = no_longer_valid_color
			end
		end
		black
	end

	def no_longer_valid_color
		"X"
	end

	def count_white_pegs(colors)
		white = 0
		colors.each do |color|
			white += [@temp_code.count(color), @temp_guess.count(color)].min
		end
		white
	end
end