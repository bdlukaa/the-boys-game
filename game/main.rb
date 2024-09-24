require 'ruby2d'
require_relative 'state'
require_relative 'game'
require_relative 'base/hughie'
require_relative 'base/superhero'
require_relative 'base/ground'
require_relative 'base/compound_v'

require_relative 'overlays/entry_screen'
require_relative 'overlays/pause_overlay'

# Configurações da Janela para Tela Cheia
set title: 'The Boys: The Game', background: 'gray', resizable: true

# Variável para os limites do chão
GROUND_Y = Window.height - 100

$backgrounds = [
  Image.new('assets/background2.png', width: Window.width, height: Window.height),
  Image.new('assets/background3.png', width: Window.width, height: Window.height),
  Image.new('assets/background4.png', width: Window.width, height: Window.height)
]

# Carrega o céu
$sky = Image.new('assets/sky.png', width: Window.width, height: Window.height)

# Carrega os pássaros
$birds = [
  Sprite.new('assets/bird1.png', width: 50, height: 50, clip_width: 50, time: 300, loop: true),
  Sprite.new('assets/bird2.png', width: 50, height: 50, clip_width: 50, time: 300, loop: true),
  Sprite.new('assets/bird3.png', width: 50, height: 50, clip_width: 50, time: 300, loop: true)
]

# Cria o personagem Hugie (ele será escondido até que o jogo comece)
$hugie = Hugie.new
$hugie.hide

# Atualiza a posição dos elementos continuamente
update do
  if $state == GameState::PLAYING
    GROUND_Y = Window.height - 100
    $ground.image.y = GROUND_Y if $ground
    $hugie.update_position if $hugie
  end
end

$state = GameState::WAITING
$entry_screen = EntryScreen.new

def reset
  set background: 'gray'

  $backgroundImage.remove if $backgroundImage
  $ground.remove if $ground
  $hugie.hide if $hugie         # Esconde o Hugie ao reiniciar o jogo
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

# Iniciar o jogo quando a tecla for pressionada
on :key_down do |event|
  if $state == GameState::WAITING
    $entry_screen.remove  # Remove a tela de entrada
    $state = GameState::PLAYING
    $hugie.show            # Mostra o Hugie ao começar o jogo
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
  when 'left', 'right', 'a', 'd'
    $hugie.change_state(:idle) if $hugie.state == :walking
    $using_arrows = false
    $using_wasd = false
  end
end

# Adiciona um evento de clique do mouse
on :mouse_down do |event|
  next if $state != GameState::PLAYING

  if event.button == :left
    $hugie.attack($superhero) if $hugie&.can_attack?
    if $superhero
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
