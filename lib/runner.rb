require_relative 'message_center.rb'
require_relative 'computer_player.rb'
require_relative 'human_player.rb'
require_relative 'guess_checker.rb'

class Runner
	attr_reader :message_center, :computer_player, :human_player, :code_maker, :guesser, :secret_code, :guess, :black, :white, :guess_counter

	def initialize
		@message_center = MessageCenter.new
		@computer_player = ComputerPlayer.new
		@human_player = HumanPlayer.new
		@guess_checker = GuessChecker.new
		@players = [@human_player, @computer_player]
	end

	def play_game
		get_players
		get_secret_code
		@message_center.display_code_message
		@guess_counter = 1
		
		until @black == 4 || @guess_counter > 10 do 
			get_guess
			@message_center.display_guess(@guess)
			check_guess
			@message_center.display_results(@black, @white) 
			@guess_counter += 1
		end

		@message_center.goodbye(@guess_counter) if @black == 4
		@message_center.game_over if @guess_counter > 10
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

	def check_guess
		@guess_checker.check_guess(@guess, @secret_code, ["R", "Y", "G", "B", "P", "O"])
		@black = @guess_checker.black
		@white = @guess_checker.white
	end
end