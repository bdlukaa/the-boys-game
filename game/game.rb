require_relative 'state'
require_relative 'base/hughie'
require_relative 'base/superhero'
require_relative 'base/ground'
require_relative 'base/compound_v'
require_relative 'overlays/lose_overlay'

def start_game
  setup_game
  update_game
end

def setup_game
  $backgroundImage = Image.new('assets/background.png', width: Window.width, height: Window.height)
  $ground = Ground.new
  $hugie = Hughie.new
  $superhero = SuperHero.new

  $life_bar_hugie = create_life_bar(10, 10, $hugie.life, 'green')
  $life_bar_superhero = create_life_bar(Window.width - 210, 10, $superhero.life, 'blue')

  $compound_v = nil
  $compound_v_timer = 0
  $alert_text = nil
  $alert_timer = 0

  $start_time = Time.now
  $time_text = Text.new("Tempo: 0s", x: 10, y: 40, size: 20, color: 'white')
end

def create_life_bar(x, y, life, color)
  Rectangle.new(x: x, y: y, width: life * 2, height: 20, color: color)
end

def update_game
  update do
    next if $state != GameState::PLAYING

    $hugie.update_position
    $superhero.move_randomly

    check_collision
    generate_compound_v
    update_alert
    update_time

    debug_positions
  end
end

def check_collision
  if $hugie.image.contains?($superhero.x, $superhero.y) && $superhero.can_attack?
    $superhero.attack($hugie)
    $life_bar_hugie.width = $hugie.life * 2
    $life_bar_hugie.color = 'red' if $hugie.life <= 20
    puts "Hughie perdeu vida! Vida restante: #{$hugie.life}"
    handle_game_over if $hugie.life <= 0
  end
end

def handle_game_over
  clear
  $state = GameState::LOSE
  $lose_overlay = LoseOverlay.new
end

def generate_compound_v
  if $compound_v.nil? && $compound_v_timer <= 0
    $compound_v = CompoundV.new
    $compound_v_timer = rand(1800..3600)
  end

  if $compound_v
    $compound_v.fall
    check_compound_v_pickup
    $compound_v = nil if $compound_v&.off_screen?
  end

  $compound_v_timer -= 1 if $compound_v_timer > 0
end

def check_compound_v_pickup
  if $hugie.image.contains?($compound_v.x, $compound_v.y)
    $hugie.velocity_y -= 5
    $hugie.attack_power = 20
    $compound_v = nil
    puts "Hughie pegou o Composto V! Agora ele está mais forte e rápido!"
    show_alert('HUGIE PEGOU O COMPOSTO V!!!', 60)
  end
end

def show_alert(message, duration)
  $alert_text = Text.new(message, x: 100, y: 100, size: 30, color: 'yellow')
  $alert_timer = duration
end

def update_alert
  if $alert_timer > 0
    $alert_timer -= 1
    if $alert_timer == 0
      $alert_text.remove
      $alert_text = nil
    end
  end
end

def update_time
  elapsed_time = (Time.now - $start_time).to_i
  $time_text.text = "Tempo: #{elapsed_time}s"
end

def debug_positions
  puts "Hughie is at #{$hugie.x}, #{$hugie.y}"
  puts "SuperHero position: #{$superhero.x}, #{$superhero.y}"
end
