require_relative '../game/ui.rb'
require_relative '../game/validity.rb'

class HumanPlayer
	include Validity
	include UI

	def select_secret_code
		give("Player 1: Please create a secret code by selecting any combination of 4 colors from (Y)ellow, (B)lue, (O)range, (R)ed, (P)urple, and (G)reen (ex: YOGY):")
		code = receive.upcase
		if valid_combination?(code)
			code
		else
			give ("**Not a valid code. Try again!**")
			select_secret_code
		end
	end

	def get_guess(black = 0, white = 0, guess = 0)
		give("Player 2: Guess a possible combination of 4 colors from (Y)ellow, (B)lue, (O)range, (R)ed, (P)urple, and (G)reen (ex: YOGY):")
		guess = receive.upcase
		if valid_combination?(guess)
			guess 
		else
			give ("**Not a valid guess. Try again!**")
			get_guess
		end
	end
end