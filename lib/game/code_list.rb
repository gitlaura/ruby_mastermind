require_relative 'guess_checker.rb'

class CodeList
	attr_accessor :possibilities, :colors

	def initialize(colors)
		@colors = colors
		create_list_of_possible_codes
	end

	def create_list_of_possible_codes
		@possibilities = @colors.repeated_permutation(4).to_a
		@possibilities.each_with_index do |possibility, index|
			@possibilities[index] = "#{possibility[0]}#{possibility[1]}#{possibility[2]}#{possibility[3]}"
		end
	end

	def update_list(black, white, guess)
		new_possibilities = []
		saved_guess = guess.to_sym
		@possibilities.each do |possible_guess|
			temp_scores = compare_possible_guess_to_current_guess(saved_guess, possible_guess)
			blackcounter, whitecounter = temp_scores.first, temp_scores.last
			if possibility_has_correct_number_of_colors?(black, blackcounter, white, whitecounter)
				new_possibilities << possible_guess
			end
		end
		@possibilities = new_possibilities
	end

	def compare_possible_guess_to_current_guess(saved_guess, possible_guess)
		GuessChecker.check_guess(saved_guess, possible_guess, @colors)
	end

	def possibility_has_correct_number_of_colors?(black, blackcounter, white, whitecounter)
		blackcounter == black && whitecounter == white
	end
end