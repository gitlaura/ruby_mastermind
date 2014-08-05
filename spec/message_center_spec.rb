require 'message_center.rb'

describe 'Message Center' do
	let(:message_center) {MessageCenter.new}

	it "displays code maker message" do 
		expect(message_center.ask_for_code_maker_message).to be_a(String)
	end

	it "ask_for_guesser_message" do 
		expect(message_center.ask_for_guesser_message).to be_a(String)
	end

	it "secret_code_message" do 
		expect(message_center.secret_code_message).to be_a(String)
	end

	it "guess_message" do 
		expect(message_center.guess_message("RRRR", 5)).to be_a(String)
	end

	it "guess_checked_message" do 
		expect(message_center.guess_checked_message(2,1)).to be_a(String)
	end

	it "invalid_selection_message" do 
		expect(message_center.invalid_selection_message).to be_a(String)
	end

	it "player_two_wins_message" do 
		expect(message_center.player_two_wins_message).to be_a(String)
	end

	it "player_one_wins_message" do 
		expect(message_center.player_one_wins_message).to be_a(String)
	end
end