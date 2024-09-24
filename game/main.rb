require 'ruby2d'
require_relative 'state'
require_relative 'game'
require_relative 'base/hughie'
require_relative 'base/superhero'
require_relative 'base/ground'
require_relative 'base/compound_v'

require_relative 'overlays/entry_screen'
require_relative 'overlays/pause_overlay'

# Configurações da Janela
set title: 'The Boys: The Game', background: 'gray', resizable: true

# Define os limites do chão
GROUND_Y = Window.height - 100

$state = GameState::WAITING
$entry_screen = EntryScreen.new

def reset
  set background: 'gray'
  $backgroundImage.remove if $backgroundImage
  $ground.remove if $ground
  $hugie.remove if $hugie
  $superhero.remove if $superhero
  $life_bar_hugie.remove if $life_bar_hugie
  $life_bar_superhero.remove if $life_bar_superhero
  $compound_v.remove if $compound_v
  $alert_text.remove if $alert_text
  $time_text.remove if $time_text
  $pause_overlay.hide if $pause_overlay
  
  if $entry_screen
    $entry_screen.show
  else
    $entry_screen = EntryScreen.new
  end

  $state = GameState::WAITING
end

on :key_down do |event|
  if $state == GameState::WAITING
    $entry_screen.remove
    $state = GameState::PLAYING
    start_game
  elsif event.key == 'escape'
    toggle_pause
  end
end

# Variáveis para rastrear o conjunto de teclas em uso
$using_wasd = false
$using_arrows = false

# Movimentação e Atualização
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

# Reset das variáveis quando as teclas são liberadas
on :key_up do |event|
  case event.key
  when 'left', 'right'
    $using_arrows = false
  when 'a', 'd'
    $using_wasd = false
  end
end

# Adiciona um evento de clique do mouse
on :mouse_down do |event|
  next if $state != GameState::PLAYING

  if event.button == :left
    if $hugie&.can_attack?
      $hugie.attack($superhero)
      $life_bar_superhero.width = $superhero.life * 2
      $life_bar_superhero.color = 'red' if $superhero.life <= 20
      puts "SuperHero perdeu vida! Vida restante: #{$superhero.life}"
      if $superhero.life <= 0
        puts "SuperHero foi derrotado!"
        close
      end
    end
  end
end

show