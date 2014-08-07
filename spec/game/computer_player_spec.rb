require_relative '../../lib/game/computer_player.rb'

describe "Computer Player" do
	let(:computer_player) {ComputerPlayer.new(["R", "Y", "G", "B", "P", "O"])}

	it "selects a secret code" do
		secret_code = computer_player.select_secret_code
		expect(secret_code.size).to eq(4)
	end

	it "creates a valid guess if it's the first guess" do
		black, white, guess = nil, nil, nil
		new_guess = computer_player.get_guess(black, white, guess)
		expect(new_guess.size).to eq(4)
	end

	it "creates a valid guess if it's a second guess" do
		black, white, guess = 1, 1, "RYYY"
		new_guess = computer_player.get_guess(black, white, guess)
		expect(new_guess.size).to eq(4)
		expect(computer_player.code_list.possibilities).not_to include("RYYY")
	end
end