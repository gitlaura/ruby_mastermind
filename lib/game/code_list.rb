require_relative 'guess_checker.rb'

class CodeList
	attr_accessor :possibilities, :new_possibilities, :temp_code, :temp_guess 
	attr_reader :colors

	def initialize(colors)
		@colors = colors
		create_list_of_possible_codes
	end

	def create_list_of_possible_codes
		@possibilities = @colors.repeated_permutation(4).to_a
		@possibilities.each_with_index do |possibility, index|
			temp_string = "#{possibility[0]}#{possibility[1]}#{possibility[2]}#{possibility[3]}"
			@possibilities[index] = temp_string
		end
	end

	def update_list(black, white, guess)
		@new_possibilities = []
		@saved_guess = guess.to_sym
		index = 0

		until index == @possibilities.size do 
			@saved_code = @possibilities[index].to_sym
			@temp_guess, @temp_code = @saved_guess.to_s, @saved_code.to_s
			blackcounter = GuessChecker.count_black_pegs(@temp_code, @temp_guess)
			whitecounter = GuessChecker.count_white_pegs(@temp_code, @temp_guess, @colors)
			update_new_possibilities(black, blackcounter, white, whitecounter, index)
			index += 1
		end

		@possibilities = @new_possibilities
	end

	def update_new_possibilities(black, blackcounter, white, whitecounter, index)
		if blackcounter == black && whitecounter == white
			@new_possibilities << @possibilities[index]
		end
	end
end