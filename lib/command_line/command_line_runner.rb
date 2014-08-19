require_relative 'command_line_main.rb'

class CommandLineRunner
	attr_reader :main
	
	def initialize
		@main = CommandLineMain.new
	end

	def play_game
		code_maker = @main.get_code_maker
		secret_code = @main.get_secret_code(code_maker)
		@main.display_secret_code_message
		guesser = @main.get_guesser
		guesses = @main.get_guesses(guesser, secret_code, true)
		@main.display_game_over_message(guesses)
	end
end