require_relative '../game/main.rb'

class WebMain < Main
	def initialize
		human_player = false
		computer_player = ComputerPlayer.new(COLORS)
		@players = [human_player, computer_player]
	end
end