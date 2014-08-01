require_relative 'lib/terminal_runner.rb'
require_relative 'lib/interface_selector.rb'

selection = InterfaceSelector.get_interface

if selection == 1
	TerminalRunner.new.play_game
elsif selection == 2
	puts "\n**Please go to localhost:4567 to play Mastermind!**\n\n"
	require_relative 'lib/sinatra_app.rb'
	SinatraApp.run!
end