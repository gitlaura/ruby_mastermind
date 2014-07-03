require_relative 'UI.rb'
require_relative 'validity.rb'

class HumanPlayer
	include UI
	include Validity

	def select_secret_code
		give("Player 1: Please create a secret code by selecting any combination of these 4 colors: Yellow, Blue, Orange, Red, Purple, and Green.\nEnter the first letter of each color (ex: YOGY):")
		code = receive.upcase
		return code if valid_combination?(code)
		give ("**Not a valid code. Try again!**")
		select_secret_code
	end

	def get_guess(black = 0, white = 0, guess = 0)
		give("Player 2: Guess a possible combination of four colors (ex: YOGY):")
		guess = receive.upcase
		return guess if valid_combination?(guess)
		give ("**Not a valid guess. Try again!**")
		get_guess
	end
end