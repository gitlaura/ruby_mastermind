require_relative 'main.rb'

class Runner
	attr_reader :main, :counter, :scores

	def initialize
		@counter = 1
		@scores = [0,0]
		@main = Main.new
	end

	def play_game
		code_maker = @main.get_code_maker
		guesser = @main.get_guesser
		secret_code = @main.get_secret_code
		@main.display_secret_code_message
		until @main.game_over?(@scores, @counter)
			guess = @main.get_guess(@counter)
			@main.display_guess_message(guess, @counter)
			@scores = @main.check_guess(guess, secret_code)
			@main.display_result(scores)
			@counter += 1
		end
		main.end_game(@scores, @counter)
	end
end