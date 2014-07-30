require 'main.rb'

describe "Main" do 
	let(:main){Main.new}

	it "gets a code maker" do 
		expect(main.message_center).to receive(:get_code_maker) {2}

		code_maker = main.get_code_maker

		expect(code_maker).to eq(main.computer_player)
	end

	it "gets a guesser" do 
		expect(main.message_center).to receive(:get_guesser) {1}

		guesser = main.get_guesser

		expect(guesser).to eq(main.human_player)
	end

	it "gets a secret code" do 
		allow_message_expectations_on_nil
		expect(main.human_player).to receive(:select_secret_code) {"RRRR"}

		code = main.get_secret_code(main.human_player)

		expect(code).to eq("RRRR")
	end

	it "displays a secret code message" do 
		expect(main.message_center).to receive(:display_code_message)

		main.display_secret_code_message
	end

	it "gets a guess" do 
		allow_message_expectations_on_nil
		expect(main.guesser).to receive(:get_guess){"RRYO"}

		guess = main.get_guess(main.guesser)

		expect(guess).to eq("RRYO")
	end

	it "displays a guess message" do 
		expect(main.message_center).to receive(:display_guess)

		main.display_guess_message("RRRR", 3)
	end

	it "checks guess" do 
		result = main.check_guess("RRYO", "RRRR")

		expect(result).to eq([2,0])
	end

	it "displays result message" do 
		expect(main.message_center).to receive(:display_results)

		main.display_result([3,0])
	end

	it "checks to see if game is over" do 
		expect(main.game_over?([2,2],11)).to eq(true)
		expect(main.game_over?([4,0],5)).to eq(true)
		expect(main.game_over?([2,2],5)).to eq(false)
	end

	it "ends the game" do 
		expect(main.message_center).to receive(:goodbye)
		main.end_game([4,0], 5)

		expect(main.message_center).to receive(:game_over)
		main.end_game([2,2], 10)
	end
end