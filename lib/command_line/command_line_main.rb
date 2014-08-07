require_relative '../game/main.rb'
require_relative '../game/ui.rb'

class CommandLineMain < Main
	include UI

	def get_code_maker
		give @message_center.ask_for_code_maker_message
		selection = receive.to_i
		if valid_player?(selection)
		 	selection
		else
			give @message_center.invalid_selection_message
			get_code_maker
		end
	end

	def get_guesser
		give @message_center.ask_for_guesser_message
		selection = receive.to_i
		if valid_player?(selection)
		 	selection
		else
			give @message_center.invalid_selection_message
			get_guesser
		end
	end

	def display_secret_code_message
		give @message_center.secret_code_message
	end

	def display_guess_message(guess, counter)
		give @message_center.guess_message(guess, counter)
	end

	def display_result(scores)
		give @message_center.guess_checked_message(scores.first, scores.last)
	end

	def end_game(scores)
		if scores.first == 4
			give @message_center.player_two_wins_message
		else 
			give @message_center.player_one_wins_message
		end
	end
end