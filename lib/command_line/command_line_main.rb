require_relative '../game/main.rb'
require_relative 'command_line_io.rb'

class CommandLineMain < Main
	include CommandLineIO

	def get_code_maker
		give MessageCenter.ask_for_code_maker_message
		selection = receive.to_i
		if valid_player?(selection)
		 	selection
		else
			give MessageCenter.invalid_selection_message
			get_code_maker
		end
	end

	def get_guesser
		give MessageCenter.ask_for_guesser_message
		selection = receive.to_i
		if valid_player?(selection)
		 	selection
		else
			give MessageCenter.invalid_selection_message
			get_guesser
		end
	end

	def display_secret_code_message
		give MessageCenter.secret_code_message
	end

	def display_guess_message(guess, counter)
		give MessageCenter.guess_message(guess, counter)
	end

	def display_result(scores)
		give MessageCenter.guess_checked_message(scores.first, scores.last)
	end

	def end_game(scores)
		if scores.first == 4
			give MessageCenter.player_two_wins_message
		else 
			give MessageCenter.player_one_wins_message
		end
	end
end