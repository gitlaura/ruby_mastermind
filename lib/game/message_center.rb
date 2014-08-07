class MessageCenter
	def ask_for_code_maker_message
		"Player 2 will try to guess the code in 10 tries. Please select a type of player:\n1) Human\n2) Computer"
	end

	def ask_for_guesser_message
		"Player 2 will try to guess the code in 10 tries. Please select a type of player:\n1) Human\n2) Computer"
	end	

	def secret_code_message
		"Player 1 created the secret code."
	end

	def guess_message(guess, guess_counter)
		"Player 2's guess ##{guess_counter} is #{guess}"
	end

	def guess_checked_message(black, white)
		"That guess gets #{black} black peg(s) and #{white} white peg(s)."
	end

	def invalid_selection_message
		"**Not a valid answer. Try again!**"
	end

	def player_two_wins_message
		"Game over! Player 2 wins!"
	end

	def player_one_wins_message
		"Game over! Player 1 wins. Player 2 did not guess correctly in 10 tries."
	end
end