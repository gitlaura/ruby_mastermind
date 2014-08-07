require_relative 'message_center.rb'
require_relative 'computer_player.rb'
require_relative '../command_line/human_player.rb'
require_relative 'guess_checker.rb'
require_relative 'validity.rb'

class Main
	include Validity

	COLORS = ["R", "Y", "G", "B", "P", "O"]

	def initialize
		@human_player = HumanPlayer.new
		@computer_player = ComputerPlayer.new(COLORS)
		@players = [@human_player, @computer_player]
	end

	def get_secret_code(code_maker)
		player = @players[code_maker - 1]
		player.select_secret_code
	end

	def get_guess(guesser, black, white, guess)
		player = @players[guesser - 1]
		player.get_guess(black, white, guess)
	end

	def check_guess(guess, secret_code)
		GuessChecker.check_guess(guess, secret_code, COLORS)
	end

	def game_over?(scores, counter)
		if scores == [4,0]
			return true
		elsif counter > 10
			return true
		end
		false
	end
end