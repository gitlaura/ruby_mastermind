require_relative '../../lib/game/main.rb'

describe "Main" do 
	let(:main){Main.new}
	let(:guesser){1}
	let(:guess){"RRPP"}
	let(:secret_code){"RPOO"}

	it "gets a secret code" do 
		code = main.get_secret_code(guesser)
		expect(code.size).to eq(4)
	end

	it "gets an array of guesses" do 
		guesses = main.get_guesses(guesser, secret_code)
		last_black_peg = guesses.last[1]
		expect(last_black_peg).to eq(4)
	end

	it "gets a guess" do 
		code = main.get_guess(guesser, 1, 0, guess)
		expect(code.size).to eq(4)
	end

	it "checks guess" do 
		result = main.check_guess(guess, secret_code)
		expect(result).to eq([1,1])
	end

	it "checks to see if game is over" do 
		expect(main.game_over?([2,2],11)).to eq(true)
		expect(main.game_over?([4,0],5)).to eq(true)
		expect(main.game_over?([2,2],5)).to eq(false)
	end

	it "returns a secret_code_message" do
		message = main.secret_code_message
		expect(message).to include("secret code")
	end

	it "returns a invalid_selection_message" do 
		message = main.invalid_selection_message
		expect(message).to include("Try again")
	end

	it "returns a game_over_message" do 
		message = main.game_over_message(["RRRR", 4, 0])
		expect(message).to include("Game over")
	end
end