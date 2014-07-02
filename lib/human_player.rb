require_relative 'UI.rb'
require_relative 'validity.rb'

class HumanPlayer
	include UI
	include Validity

	attr_accessor :guess

	def select_secret_code
		give("First you need to create a secret code. It can be any combination of four of the colors Y, B, O, R, P, and G.\nPlease enter your secret code:")
		code = receive.upcase
		return code if valid_combination?(code)
		give ("**Not a valid code. Try again!**")
		select_secret_code
	end

	def get_guess(black = 0, white = 0, guess = 0)
		give("Guess a possible combination of four colors:")
		guess = receive.upcase
		return guess if valid_combination?(guess)
		give ("**Not a valid guess. Try again!**")
		get_guess
	end
end