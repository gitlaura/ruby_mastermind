require_relative 'validity.rb'
require_relative 'main.rb'

class WebRunner
	include Validity

	attr_reader :main

	def initialize
		@main = Main.new
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
			guesses = add_guess(guess, scores)
			counter += 1
		end
		guesses
	end

	def check_guess(guess, secret_code)
		scores = @main.check_guess(guess, secret_code)
	end

	def add_guess(guess, scores)
		@guesses ||= []
		@guesses <<  {:guess => guess, :black => scores.first, :white => scores.last}
	end

end