require_relative '../../lib/command_line/human_player.rb'

describe "Human player" do 
	before(:each) do 
		@human_player = HumanPlayer.new
	end

	it "selects a secret code" do
		expect(@human_player).to receive(:give)
		expect(@human_player).to receive(:receive) {"RYOP"}
		secret_code = @human_player.select_secret_code
		expect(secret_code).to include("RYOP")
	end

	it "makes a guess" do 
		expect(@human_player).to receive(:give)
		expect(@human_player).to receive(:receive) {"RYOP"}
		guess = @human_player.get_guess
		expect(guess).to include("RYOP")
	end
end