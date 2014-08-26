require_relative '../../../lib/command_line/command_line_runner.rb'
describe "Command Line Runner" do  
	it "runs the command line game" do
		runner = CommandLineRunner.new

		expect(runner.main).to receive(:get_code_maker) {2}
		expect(runner.main).to receive(:get_secret_code) {2}
		expect(runner.main).to receive(:display_secret_code_message)
		expect(runner.main).to receive(:get_guesser)
		expect(runner.main).to receive(:get_guesses)
		expect(runner.main).to receive(:display_game_over_message)
		runner.play_game
	end
end