require 'ruby2d'
require_relative 'state'
require_relative 'game'
require_relative 'base/hughie'
require_relative 'base/superhero'
require_relative 'base/ground'
require_relative 'base/compound_v'
require_relative 'overlays/entry_screen'
require_relative 'overlays/pause_overlay'
require_relative 'overlays/win_overlay'

# Window Configuration
set title: 'The Boys: The Game', background: 'gray', resizable: true, fullscreen: true, width: 1920, height: 1080

GROUND_Y = Window.height - 100

update do
  if $state == GameState::PLAYING
    GROUND_Y = Window.height - 100
    $ground.image.y = GROUND_Y if $ground
    $hugie.update_position if $hugie
  end
end

$state = GameState::WAITING
$entry_screen = EntryScreen.new

def clear
  set background: 'gray'
  clear_game
  $pause_overlay&.hide
end

def reset
  clear
  $entry_screen ? $entry_screen.show : $entry_screen = EntryScreen.new
  $state = GameState::WAITING
end

on :key_down do |event|
  if $state == GameState::WAITING
    $entry_screen.remove
    $state = GameState::PLAYING
    start_game
  elsif $state == GameState::PLAYING && event.key == 'escape'
    toggle_pause
  end
end

show
