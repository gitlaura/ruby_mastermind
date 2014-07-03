class CodeList
	attr_accessor :possibilities, :temp_code, :temp_guess, :new_possibilities
	attr_reader :colors

	def initialize(colors)
		@possibilities = []
		@colors = colors
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

	def update_list(black, white, guess)
		@new_possibilities = []
		@saved_guess = guess.to_sym
		index = 0

		until index == @possibilities.size do 
			@saved_code = @possibilities[index].to_sym
			@temp_guess, @temp_code = @saved_guess.to_s, @saved_code.to_s
			blackcounter = count_black_pegs
			whitecounter = count_white_pegs
			update_new_possibilities(black, blackcounter, white, whitecounter, index)
			index += 1
		end

		@possibilities = @new_possibilities
	end

	def count_black_pegs
		blackcounter = 0
		(0..3).each do |index|
			if @temp_code[index] == @temp_guess[index]
				blackcounter += 1
				@temp_code[index] = "X"
				@temp_guess[index] = "X"
			end
		end
		blackcounter
	end

	def count_white_pegs
		whitecounter = 0
		@colors.each do |color|
			whitecounter += [@temp_code.count(color), @temp_guess.count(color)].min
		end
		whitecounter
	end

	def update_new_possibilities(black, blackcounter, white, whitecounter, index)
		if blackcounter == black && whitecounter == white
			@new_possibilities << @possibilities[index]
		end
	end

	def delete_invalid_possibilities
		@possibilities.delete("INVALID")
		@possibilities
	end
end