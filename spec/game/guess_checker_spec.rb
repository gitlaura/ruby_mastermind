require_relative '../../lib/game/guess_checker.rb'

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

	it "gives 2 black pegs and 2 white pegs if four colors match" do
		guess = "RORP"
		@guess_checker.check_guess(guess, @code, @colors)
		expect(@guess_checker.black).to eq(0)
		expect(@guess_checker.white).to eq(3)
	end

	it "gives 4 black pegs if four colors match" do
		guess = "PPOR"
		@guess_checker.check_guess(guess, @code, @colors)
		expect(@guess_checker.black).to eq(4)
		expect(@guess_checker.white).to eq(0)
	end

	it "counts the black pegs" do
		@guess_checker.temp_code = "RRRR"
		@guess_checker.temp_guess = "RRPP"
		expect(@guess_checker.count_black_pegs).to eq(2)
		expect(@guess_checker.temp_code).to eq("XXRR")
		expect(@guess_checker.temp_guess).to eq("XXPP")

		@guess_checker.temp_code = "RRRR"
		@guess_checker.temp_guess = "GGPP"
		expect(@guess_checker.count_black_pegs).to eq(0)
		expect(@guess_checker.temp_code).to eq("RRRR")
		expect(@guess_checker.temp_guess).to eq("GGPP")
	end

	it "counts the white pegs" do
		@guess_checker.temp_code = "RXRX"
		@guess_checker.temp_guess = "GRPP"
		expect(@guess_checker.count_white_pegs(@colors)).to eq(1)

		@guess_checker.temp_code = "GGXP"
		@guess_checker.temp_guess = "ORRB"
		expect(@guess_checker.count_white_pegs(@colors)).to eq(0)
	end
end