require_relative 'runner.rb'

class UIWeb
	class << self
		attr_reader :black, :white
		def get_result(guess, secret_code)
			runner = Runner.new
			runner.check_guess(guess, secret_code)
			@black = runner.black
			@white = runner.white
		end
	end
end