require_relative 'message_center.rb'
require_relative 'computer_player.rb'
require_relative 'human_player.rb'
require_relative 'guess_checker.rb'

class Main
	attr_reader :interface, :message_center, :computer_player, :human_player, :code_maker, :guesser, :secret_code, :guess, :black, :white

	COLORS = ["R", "Y", "G", "B", "P", "O"]

	def initialize
		@message_center = MessageCenter.new
		@human_player = HumanPlayer.new
		@computer_player = ComputerPlayer.new(COLORS)
		@guess_checker = GuessChecker.new
		@players = [@human_player, @computer_player]
	end

	def get_code_maker
		@code_maker = @players[@message_center.get_code_maker - 1]
	end

	def get_guesser
		@guesser = @players[@message_center.get_guesser - 1]
	end

	def get_secret_code
		@secret_code = @code_maker.select_secret_code
	end

	def display_secret_code_message
		@message_center.display_code_message
	end

	def get_guess(guess_counter)
		@guess = @guesser.get_guess(@black, @white, @guess)
	end

	def display_guess_message(guess, counter)
		@message_center.display_guess(guess, counter)
	end

	def check_guess(guess, secret_code)
		@guess_checker.check_guess(guess, secret_code, COLORS)
		@black = @guess_checker.black
		@white = @guess_checker.white
		[@black, @white]
	end

	def display_result(scores)
		black, white = scores.first, scores.last
		@message_center.display_results(black, white)
	end

	def game_over?(scores, counter)
		if scores == [4,0]
			return true
		elsif counter > 10
			return true
		else
			return false
		end
	end

	def end_game(scores, counter)
		if scores.first == 4
			@message_center.goodbye(counter - 1)
		else 
			@message_center.game_over
		end
	end
end