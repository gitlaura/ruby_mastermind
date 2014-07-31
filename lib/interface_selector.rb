require_relative 'validity.rb'
require_relative 'ui.rb'

class InterfaceSelector
	class << self

		include Validity
		include UI

		def get_interface
			give "\nWhere would you like to play mastermind?\n1)Command Line\n2)Web\nPlease select a numeric option:"
			selection = receive.to_i
			return selection if valid_interface?(selection)
			puts "Oops, try again!"
			get_interface
		end
	end
end