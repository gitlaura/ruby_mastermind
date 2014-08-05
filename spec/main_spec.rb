require 'main.rb'

describe "Main" do 
	let(:main){Main.new}

	it "gets a secret code" do 
		code = main.get_secret_code(2)

		expect(code.size).to eq(4)
	end

	it "gets a guess" do 
		code = main.get_guess(2)

		expect(code.size).to eq(4)
	end

	it "checks guess" do 
		result = main.check_guess("RRYO", "RRRR")

		expect(result).to eq([2,0])
	end

	it "checks to see if game is over" do 
		expect(main.game_over?([2,2],11)).to eq(true)
		expect(main.game_over?([4,0],5)).to eq(true)
		expect(main.game_over?([2,2],5)).to eq(false)
	end
end