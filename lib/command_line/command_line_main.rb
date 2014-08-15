require_relative '../game/main.rb'
require_relative 'command_line_io.rb'
require_relative 'command_line_human_player.rb'

class CommandLineMain < Main
	include CommandLineIO

	def initialize
		human_player = CommandLineHumanPlayer.new
		computer_player = ComputerPlayer.new(COLORS)
		@players = [human_player, computer_player]
	end

	def get_code_maker
		give MessageCenter.ask_for_code_maker_message
		selection = receive.to_i
		if valid_player?(selection)
		 	selection
		else
			give invalid_selection_message
			get_code_maker
		end
	end

	def get_guesser
		give MessageCenter.ask_for_guesser_message
		selection = receive.to_i
		if valid_player?(selection)
		 	selection
		else
			give invalid_selection_message
			get_guesser
		end
	end

	def display_secret_code_message
		give secret_code_message
	end

	def display_scores(guess, counter)
		black, white = guess[1], guess[2]
		give MessageCenter.guess_message(guess[0], counter)
		give MessageCenter.guess_checked_message(black, white)
	end

	def display_game_over_message(guesses)
		give game_over_message(guesses)
	end
end