require_relative 'UI.rb'

class HumanPlayer
	include UI

	attr_accessor :guess

	def select_secret_code
		give("First you need to create a secret code. It can be any combination of four of the colors Y, B, O, R, P, and G.\nPlease enter your secret code:")
		receive
	end

	def get_guess
		give("Guess a possible combination of four colors:")
		receive
	end
end