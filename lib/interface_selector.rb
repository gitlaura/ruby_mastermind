require_relative 'game/validity.rb'
require_relative 'command_line/command_line_io.rb'

class InterfaceSelector
	class << self

		include Validity
		include CommandLineIO

		def get_interface
			give "\nWhere would you like to play mastermind?\n1)Command Line\n2)Web\nPlease select a numeric option:"
			selection = receive.to_i
			if valid_interface?(selection)
				selection
			else
				puts "Oops, try again!"
				get_interface
			end
		end
	end
end