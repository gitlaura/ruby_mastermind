require_relative 'message_center.rb'
require_relative 'computer_player.rb'
require_relative 'human_player.rb'
require_relative 'guess_checker.rb'
require_relative 'ui.rb'
require_relative 'ui_web.rb'

class Runner
	attr_reader :message_center, :computer_player, :human_player, :code_maker, :guesser, :secret_code, :guess, :black, :white

	COLORS = ["R", "Y", "G", "B", "P", "O"]

	def initialize
		@message_center = MessageCenter.new
		@human_player = HumanPlayer.new
		@computer_player = ComputerPlayer.new(COLORS)
		@guess_checker = GuessChecker.new
		@players = [@human_player, @computer_player]
	end

	def play_game
		get_players
		get_secret_code
		@message_center.display_code_message
		guess_counter = 1
		
		until @black == 4 || guess_counter > 10 do 
			get_guess
			@message_center.display_guess(@guess, guess_counter)
			check_guess(@guess, @secret_code)
			@message_center.display_results(@black, @white) 
			guess_counter += 1
		end

		if @black == 4
			@message_center.goodbye(guess_counter - 1)
		else 
			@message_center.game_over
		end
	end

	def get_players
		@code_maker = @players[@message_center.get_code_maker - 1]
		@guesser = @players[@message_center.get_guesser - 1]
	end

	def get_secret_code
		@secret_code = @code_maker.select_secret_code
	end

	def get_guess
		@guess = @guesser.get_guess(@black, @white, @guess)
	end

	def check_guess(guess, secret_code)
		@guess_checker.check_guess(guess, secret_code, COLORS)
		@black = @guess_checker.black
		@white = @guess_checker.white
	end
end