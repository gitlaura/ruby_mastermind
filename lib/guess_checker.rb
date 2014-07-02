class GuessChecker
	attr_accessor :code, :guess, :black, :white

	def check_guess(guess, code, colors)
		@code = code
		@guess = guess
		@black = 0
		@white = 0
		saved_guess = guess.to_sym
		saved_code = code.to_sym

		index = 0
		temp_guess = saved_guess.to_s 
		temp_code = saved_code.to_s
		
		until index == 4 do 
			if guess[index] == code[index]
				@black += 1
				temp_guess[index] = "X"
				temp_code[index] = "X"
			end
			index += 1
		end

		colors.each do |color|
			temp_guess_color_count = temp_guess.count(color)
			temp_code_color_count = temp_code.count(color)

			if temp_code_color_count == 0 || temp_guess_color_count == 0
				@white
			elsif temp_code_color_count == temp_guess_color_count
				@white += temp_code_color_count
			else
				@white += [temp_code_color_count, temp_guess_color_count].min
			end
		end
	end
end