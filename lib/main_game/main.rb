require_relative 'message_center.rb'
require_relative 'computer_player.rb'
require_relative '../command_line/human_player.rb'
require_relative 'guess_checker.rb'
require_relative 'validity.rb'

class Main
	attr_accessor :code_maker, :guesser
	attr_reader :interface, :message_center, :computer_player, :human_player, :players, :secret_code, :guess, :black, :white

	include Validity

	COLORS = ["R", "Y", "G", "B", "P", "O"]

	def initialize
		@message_center = MessageCenter.new
		@human_player = HumanPlayer.new
		@computer_player = ComputerPlayer.new(COLORS)
		@guess_checker = GuessChecker.new
		@players = [@human_player, @computer_player]
	end

	def get_secret_code(code_maker)
		player = @players[code_maker - 1]
		@secret_code = player.select_secret_code
	end

	def get_guess(guesser)
		player = @players[guesser - 1]
		@guess = player.get_guess(@black, @white, @guess)
	end

	def check_guess(guess, secret_code)
		@guess_checker.check_guess(guess, secret_code, COLORS)
		@black = @guess_checker.black
		@white = @guess_checker.white
		[@black, @white]
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