require 'code_checker.rb'

describe "Code checker" do 
	before(:each) do 
		@colors = ["R", "Y", "G", "B", "P", "O"]
		@code_checker = CodeChecker.new
		@code = "PPOR"
	end

	it "gives 0 black pegs and 0 white pegs if nothing matches" do
		guess = "YYYY"
		@code_checker.eval(guess, @code, @colors)
		expect(@code_checker.black).to eq(0)
		expect(@code_checker.white).to eq(0)
	end

	it "gives 2 black pegs and 0 white pegs if two colors match" do
		guess = "PPYY"
		@code_checker.eval(guess, @code, @colors)
		expect(@code_checker.black).to eq(2)
		expect(@code_checker.white).to eq(0)
	end

	it "gives 2 black pegs and 2 white pegs if four colors match" do
		guess = "PPRO"
		@code_checker.eval(guess, @code, @colors)
		expect(@code_checker.black).to eq(2)
		expect(@code_checker.white).to eq(2)
	end

	it "gives 0 black pegs and 2 white pegs if two colors match" do
		guess = "RRRO"
		@code_checker.eval(guess, @code, @colors)
		expect(@code_checker.black).to eq(0)
		expect(@code_checker.white).to eq(2)
	end

	it "gives 4 black pegs if four colors match" do
		guess = "PPOR"
		@code_checker.eval(guess, @code, @colors)
		expect(@code_checker.black).to eq(4)
		expect(@code_checker.white).to eq(0)
	end
end