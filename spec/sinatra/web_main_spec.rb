require_relative '../../lib/sinatra/web_main'

describe "Web Main" do 
	let(:web_main) {WebMain.new}

	it "display_secret_code_message" do 
		expect(web_main.message_center).to receive(:secret_code_message)

		web_main.display_secret_code_message
	end

	it "get_guesses" do 
		guesses = web_main.get_guesses(2, "RORO")

		expect(guesses.size).to be < 11
		expect(guesses.size).to be > 0
		expect(guesses.last[1]).to be(4)
	end

	it "creates an array of guesses" do 
		guesses = web_main.create_array_of_guesses("RRRR", [["guess", "RRRR"], ["guess","PRPR"], ["guess","OBOY"]])

		expect(guesses.first[0]).to eq("PRPR")
		expect(guesses.last[1]).to eq(0)
	end

	it "gives an invalid selection message" do 
		expect(web_main.message_center).to receive(:invalid_selection_message)

		web_main.invalid_selection_message
	end

	it "ends the game" do 
		expect(web_main.message_center).to receive(:player_two_wins_message)

		web_main.end_game([["RPRP", 4, 0]])
	end
end