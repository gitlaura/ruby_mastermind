require_relative 'lib/terminal_runner.rb'
require_relative 'lib/web_runner.rb'
require_relative 'lib/interface_selector.rb'

selection = InterfaceSelector.get_interface

if selection == 1
	runner = TerminalRunner.new
	runner.play_game
elsif selection == 2
	runner = WebRunner.new
	runner.play_game
end