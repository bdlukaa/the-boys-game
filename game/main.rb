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

$backgrounds = [
  Image.new('assets/background/background2.png', width: Window.width, height: Window.height),
  Image.new('assets/background/background3.png', width: Window.width, height: Window.height),
  Image.new('assets/background/background4.png', width: Window.width, height: Window.height)
]

$birds = [
  Sprite.new('assets/birds/bird1.png', width: 50, height: 50, clip_width: 50, time: 300, loop: true),
  Sprite.new('assets/birds/bird2.png', width: 50, height: 50, clip_width: 50, time: 300, loop: true),
  Sprite.new('assets/birds/bird3.png', width: 50, height: 50, clip_width: 50, time: 300, loop: true)
]

$hugie = Hughie.new
$hugie.hide

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
  [$backgroundImage, $ground, $superhero, $life_bar_hugie, $life_bar_superhero, $compound_v, $alert_text, $time_text].each(&:remove)
  $hugie.hide if $hugie
  $pause_overlay.hide if $pause_overlay
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
    $hugie.show
    start_game
  elsif $state == GameState::PLAYING && event.key == 'escape'
    toggle_pause
  end
end

$using_wasd = false
$using_arrows = false

on :key_held do |event|
  next if $state != GameState::PLAYING

  case event.key
  when 'left'
    unless $using_wasd
      $using_arrows = true
      $hugie.move_left if $hugie
    end
  when 'right'
    unless $using_wasd
      $using_arrows = true
      $hugie.move_right if $hugie
    end
  when 'a'
    unless $using_arrows
      $using_wasd = true
      $hugie.move_left if $hugie
    end
  when 'd'
    unless $using_arrows
      $using_wasd = true
      $hugie.move_right if $hugie
    end
  when 'space'
    $hugie.jump if $hugie&.on_ground?
  end
end

on :key_up do |event|
  if %w[left right a d].include?(event.key)
    $hugie.send(:change_state, :idle) if $hugie.state == :walking
    $using_arrows = false
    $using_wasd = false
  end
end

on :mouse_down do |event|
  next if $state != GameState::PLAYING

  if event.button == :left
    $hugie.attack($superhero) if $hugie&.can_attack?
    if $superhero
      $life_bar_superhero.width = $superhero.life * 2
      $life_bar_superhero.color = 'red' if $superhero.life <= 20
      puts "SuperHero perdeu vida! Vida restante: #{$superhero.life}"
      if $superhero.life <= 0
        clear
        $win_overlay = WinOverlay.new
        $state = GameState::WIN
      end
    end
  end
end

show
