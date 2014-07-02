class CodeList
	attr_accessor :possibilities
	attr_reader :colors

	def initialize
		@possibilities = []
		@colors = ["R", "Y", "G", "B", "P", "O"]
		colors.each do |spot_one|
			colors.each do |spot_two|
				colors.each do |spot_three|
					colors.each do |spot_four|
						@possibilities << (spot_one + spot_two + spot_three + spot_four)
					end
				end
			end
		end
	end

	def update_list(black_pegs, white_pegs, guess)		
		index = 0
		saved_guess = guess.to_sym

		until index == @possibilities.size do
			blackcounter, whitecounter = 0, 0
			saved_code = @possibilities[index].to_sym
			temp_code = saved_code.to_s
			temp_guess = saved_guess.to_s

			char = 0
			until char == 4 do 
				if temp_code[char] == temp_guess[char]
					blackcounter += 1
					temp_code[char] = "X"
					temp_guess[char] = "X"
				end
				char += 1
			end

			@colors.each do |color|
				temp_code_color_count = temp_code.count(color)
				temp_guess_color_count = temp_guess.count(color)
				if temp_code_color_count == 0 || temp_guess_color_count == 0
					whitecounter = whitecounter
				elsif temp_code_color_count == temp_guess_color_count
					whitecounter += 1
				else
					whitecounter = [temp_code_color_count, temp_guess_color_count].min
				end
			end

			if blackcounter != black_pegs || whitecounter != white_pegs
				@possibilities[index] = "INVALID" 
			end

			index += 1	
		end

		@possibilities.delete("INVALID")
		@possibilities
	end
end