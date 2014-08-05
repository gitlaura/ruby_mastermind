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

	it "displays a guess message" do 
		expect(command_line_main).to receive(:give) 

		command_line_main.display_guess_message("RRRR", 5)
	end

	it "displays a result" do 
		expect(command_line_main).to receive(:give) 

		command_line_main.display_result([3, 0])
	end

	it "ends game" do 
		expect(command_line_main).to receive(:give) 

		command_line_main.display_result([4, 0])
	end
end