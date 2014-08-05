require 'terminal_main'

describe "Terminal Main" do 
	let(:terminal_main) {TerminalMain.new}

	it "gets a code maker" do 
		expect(terminal_main).to receive(:give) 
		expect(terminal_main).to receive(:receive) {2}

		code_maker = terminal_main.get_code_maker

		expect(code_maker).to eq(2)
	end

	it "gets a guesser" do 
		expect(terminal_main).to receive(:give) 
		expect(terminal_main).to receive(:receive) {2}

		guesser = terminal_main.get_guesser

		expect(guesser).to eq(2)
	end

	it "displays a secret code message" do 
		expect(terminal_main).to receive(:give) 

		terminal_main.display_secret_code_message
	end

	it "displays a guess message" do 
		expect(terminal_main).to receive(:give) 

		terminal_main.display_guess_message("RRRR", 5)
	end

	it "displays a result" do 
		expect(terminal_main).to receive(:give) 

		terminal_main.display_result([3, 0])
	end

	it "ends game" do 
		expect(terminal_main).to receive(:give) 

		terminal_main.display_result([4, 0])
	end
end