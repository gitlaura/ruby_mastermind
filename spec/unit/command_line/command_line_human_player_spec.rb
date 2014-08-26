require_relative '../../../lib/command_line/command_line_human_player.rb'

describe "Command Line Human player" do 
	let(:human_player) {CommandLineHumanPlayer.new}

	it "selects a secret code" do
		expect(human_player).to receive(:give)
		expect(human_player).to receive(:receive) {"RYOP"}

		secret_code = human_player.select_secret_code

		expect(secret_code).to include("RYOP")
	end

	it "makes a guess" do 
		expect(human_player).to receive(:give)
		expect(human_player).to receive(:receive) {"RYOP"}

		guess = human_player.get_guess
		
		expect(guess).to include("RYOP")
	end
end