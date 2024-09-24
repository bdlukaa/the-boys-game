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
entry_screen = EntryScreen.new

on :key_down do |event|
  if $state == GameState::WAITING
    entry_screen.remove
    $state = GameState::PLAYING
    start_game
  elsif event.key == 'escape'
    $state = $state == GameState::PAUSED ? GameState::PLAYING : GameState::PAUSED
    if $state == GameState::PAUSED
      $pause_overlay = PauseOverlay.new
    else
      $pause_overlay.hide if $pause_overlay
    end
  end
end

# Movimentação e Atualização
on :key_held do |event|
  next if $state != GameState::PLAYING

  case event.key
  when 'left', 'a'
    $hugie.move_left if $hugie
  when 'right', 'd'
    $hugie.move_right if $hugie
  when 'space'
    $hugie.jump if $hugie&.on_ground?
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