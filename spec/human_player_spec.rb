require 'human_player.rb'

describe "Human player" do 
	before(:each) do 
		@human_player = HumanPlayer.new
	end

	it "selects a secret code" do
		@human_player.should_receive(:give)
		@human_player.should_receive(:receive) {"RYOP"}
		secret_code = @human_player.select_secret_code
		expect(secret_code).to include("RYOP")
	end

	it "makes a guess" do 
		@human_player.should_receive(:give)
		@human_player.should_receive(:receive) {"RYOP"}
		guess = @human_player.get_guess
		expect(guess).to include("RYOP")
	end
end