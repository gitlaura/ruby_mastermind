require 'io_runner.rb'

describe "IO Runner" do  
	it "runs the command line game" do
		runner = IORunner.new

		expect(runner.main).to receive(:get_code_maker)
		expect(runner.main).to receive(:get_guesser)
		expect(runner.main).to receive(:get_secret_code)
		expect(runner.main).to receive(:display_secret_code_message)
		expect(runner.main).to receive(:game_over?){true}
		expect(runner.main).to receive(:end_game)

		runner.play_game
	end
end