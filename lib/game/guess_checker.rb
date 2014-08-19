class GuessChecker
	class << self
		def check_guess(guess, code, colors)
			saved_code, saved_guess = code.to_sym, guess.to_sym
			temp_guess, temp_code = saved_guess.to_s, saved_code.to_s
			black = count_black_pegs(temp_guess, temp_code)
			white = count_white_pegs(temp_guess, temp_code, colors)
			[black, white]
		end

		def count_black_pegs(temp_code, temp_guess)
			black = 0
			(0..3).each do |index|
				if temp_code[index] == temp_guess[index]
					black += 1
					temp_code[index] = disable_color
					temp_guess[index] = disable_color
				end
			end
			black
		end

		def disable_color
			"X"
		end

		def count_white_pegs(temp_code, temp_guess, colors)
			white = 0
			colors.each do |color|
				white += [temp_code.count(color), temp_guess.count(color)].min
			end
			white
		end
	end
end