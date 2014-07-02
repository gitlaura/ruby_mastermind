require 'guess_checker.rb'

describe "Guess checker" do 
	before(:each) do 
		@colors = ["R", "Y", "G", "B", "P", "O"]
		@guess_checker = GuessChecker.new
		@code = "PPOR"
	end

	it "gives 0 black pegs and 0 white pegs if nothing matches" do
		guess = "YYYY"
		@guess_checker.check_guess(guess, @code, @colors)
		expect(@guess_checker.black).to eq(0)
		expect(@guess_checker.white).to eq(0)
	end

	it "gives 2 black pegs and 0 white pegs if two colors match" do
		guess = "PPYY"
		@guess_checker.check_guess(guess, @code, @colors)
		expect(@guess_checker.black).to eq(2)
		expect(@guess_checker.white).to eq(0)
	end

	it "gives 2 black pegs and 2 white pegs if four colors match" do
		guess = "RORP"
		@guess_checker.check_guess(guess, @code, @colors)
		expect(@guess_checker.black).to eq(0)
		expect(@guess_checker.white).to eq(3)
	end

	it "gives 0 black pegs and 2 white pegs if two colors match" do
		guess = "RRRO"
		@guess_checker.check_guess(guess, @code, @colors)
		expect(@guess_checker.black).to eq(0)
		expect(@guess_checker.white).to eq(2)
	end

	it "gives 4 black pegs if four colors match" do
		guess = "PPOR"
		@guess_checker.check_guess(guess, @code, @colors)
		expect(@guess_checker.black).to eq(4)
		expect(@guess_checker.white).to eq(0)
	end
end