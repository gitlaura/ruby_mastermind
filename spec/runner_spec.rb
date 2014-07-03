require 'runner.rb'

describe "Runner" do  
	before(:each) do 
		@runner = Runner.new
		expect(@runner.message_center).to receive(:get_code_maker) {2}
		expect(@runner.message_center).to receive(:get_guesser) {2}
		@runner.get_players
	end

	it "gets players" do
		expect(@runner.code_maker).to eq(@runner.computer_player)
		expect(@runner.guesser).to eq(@runner.computer_player)
	end

	it "creates secret code" do 
		@runner.get_secret_code
		expect(@runner.secret_code.size).to eq(4)
	end

	it "gets a guess from the guesser" do 
		@runner.get_guess
		expect(@runner.guess.size).to eq(4)
	end

	it "displays the black and white pegs" do 
		@runner.get_secret_code
		@runner.get_guess
		@runner.check_guess
		expect(@runner.black).to be_between(0, 4)
		expect(@runner.white).to be_between(0, 4)
	end
end