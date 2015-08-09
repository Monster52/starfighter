require 'gosu'
require_relative 'game_state'
require_relative 'menu_state'
require_relative 'play_state'
require_relative 'game_window'

$window = GameWindow.new
GameState.switch(MenuState.instance)
$window.show
