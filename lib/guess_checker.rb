class GuessChecker
	attr_accessor :black, :white, :temp_code, :temp_guess

	def check_guess(guess, code, colors)
		@temp_guess, @temp_code = guess, code
		@black = count_black_pegs
		@white = count_white_pegs(colors)
	end

	def count_black_pegs
		black = 0
		(0..3).each do |index|
			if @temp_code[index] == @temp_guess[index]
				black += 1
				@temp_code[index] = "X"
				@temp_guess[index] = "X"
			end
		end
		black
	end

	def count_white_pegs(colors)
		white = 0
		colors.each do |color|
			white += [@temp_code.count(color), @temp_guess.count(color)].min
		end
		white
	end
end