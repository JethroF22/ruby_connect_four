$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require "connect_four"

game = Game.new(STDOUT, STDIN)
game.start
game.main
