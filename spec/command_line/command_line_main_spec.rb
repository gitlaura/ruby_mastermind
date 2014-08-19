require_relative '../../lib/command_line/command_line_main.rb'

describe "Command Line Main" do 
	let(:command_line_main) {CommandLineMain.new}

	it "gets a code maker" do 
		expect(command_line_main).to receive(:give) 
		expect(command_line_main).to receive(:receive) {2}

		code_maker = command_line_main.get_code_maker

		expect(code_maker).to eq(2)
	end

	it "gets a guesser" do 
		expect(command_line_main).to receive(:give) 
		expect(command_line_main).to receive(:receive) {2}

		guesser = command_line_main.get_guesser

		expect(guesser).to eq(2)
	end

	it "displays a secret code message" do 
		expect(command_line_main).to receive(:give) 

		command_line_main.display_secret_code_message
	end

	it "displays the scores" do 
		expect(command_line_main).to receive(:give).twice

		command_line_main.display_scores([3, 0], 2)
	end

	it "displays game over message" do 
		expect(command_line_main).to receive(:give) 

		command_line_main.display_game_over_message(["RRPP", 4, 0])
	end
end