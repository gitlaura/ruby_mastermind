require_relative 'main.rb'

class WebRunner
	attr_reader :main

	def initialize
		@main = Main.new
	end

	def play_game
		puts "\n**Please go to localhost:4567 to play Mastermind!**\n\n"
		require_relative 'sinatra_app.rb'
		SinatraApp.run!
	end

	def get_secret_code(code_maker)
		@main.get_secret_code(@main.players[code_maker - 1])
	end

	def get_guesses(guesser, secret_code)
		scores = [0,0]
		counter = 1
		guesses = []
		until @main.game_over?(scores, counter)
			guess = @main.get_guess(@main.players[guesser - 1])
			scores = check_guess(guess,secret_code)
			guesses = add_guess(guess, scores, guesses)
			counter += 1
		end
		guesses
	end

	def check_guess(guess, secret_code)
		scores = @main.check_guess(guess, secret_code)
	end

	def add_guess(guess, scores, guesses)
		guesses <<  [guess, scores.first, scores.last]
	end

end