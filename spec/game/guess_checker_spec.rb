require_relative '../../lib/game/guess_checker.rb'

describe "Guess checker" do 
	let(:colors) {["R", "Y", "G", "B", "P", "O"]}
	let(:code) {"PPOR"}

	it "gives 0 black pegs and 0 white pegs if nothing matches" do
		guess = "YYYY"
		scores = GuessChecker.check_guess(guess, code, colors)
		expect(scores).to eq([0,0])
	end

	it "gives 2 black pegs and 2 white pegs if four colors match" do
		guess = "PPRO"
		scores = GuessChecker.check_guess(guess, code, colors)
		expect(scores).to eq([2,2])
	end

	it "gives 4 black pegs if four colors match" do
		guess = "PPOR"
		scores = GuessChecker.check_guess(guess, code, colors)
		expect(scores).to eq([4,0])
	end

	it "counts the black pegs" do
		temp_code = "RRRR"
		temp_guess = "RRPP"
		expect(GuessChecker.count_black_pegs(temp_code, temp_guess)).to eq(2)
	end

	it "counts the white pegs" do
		temp_code = "RXRX"
		temp_guess = "GRPP"
		expect(GuessChecker.count_white_pegs(temp_code, temp_guess, colors)).to eq(1)
	end
end