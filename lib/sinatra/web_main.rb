class WebMain < Main
	def display_secret_code_message
		MessageCenter.secret_code_message
	end

	def get_guesses(guesser, secret_code)
		scores = [0,0]
		counter = 1
		guesses = []
		until game_over?(scores, counter)
			guess = get_guess(guesser, scores.first, scores.last, guess)
			scores = check_guess(guess,secret_code)
			guesses <<  [guess, scores.first, scores.last]
			counter += 1
		end
		guesses
	end

	def create_array_of_guesses(secret_code, params, valid_guess = true)
		guesses = []
		params.each_with_index do |param, index|
			if index > 0 && !param[1].empty?
				guess = param[1].upcase
				scores = check_guess(guess, secret_code)
				guesses <<  [guess, scores.first, scores.last]
			end
		end
		if valid_guess == false
			guesses.pop
		end
		guesses
	end

	def invalid_selection_message
		MessageCenter.invalid_selection_message
	end

	def end_game(guesses)
		scores_of_last_guess = [guesses.last[1], guesses.last[2]]
		if scores_of_last_guess.first == 4
			MessageCenter.player_two_wins_message
		else 
			MessageCenter.player_one_wins_message
		end
	end
end