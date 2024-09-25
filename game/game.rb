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
  $backgroundImage = Image.new('assets/background/background.png', width: Window.width, height: Window.height)
  $birds = [
    Sprite.new('assets/birds/bird1.png', width: 50, height: 50, clip_width: 50, time: 300, loop: true),
    Sprite.new('assets/birds/bird2.png', width: 50, height: 50, clip_width: 50, time: 300, loop: true),
    Sprite.new('assets/birds/bird3.png', width: 50, height: 50, clip_width: 50, time: 300, loop: true)
  ]
  $ground = Ground.new
  $hugie = Hughie.new
  $superhero = SuperHero.new

  $life_bar_hugie = create_life_bar(10, 10, $hugie.life, 'green')
  $life_bar_superhero = create_life_bar(Window.width - 210, 10, $superhero.life, 'blue')

  $compound_v = nil
  $compound_v_timer = 0
  $compound_v_effect_timer = 0
  $compound_v_bar = nil
  $alert_text = nil
  $alert_timer = 0

  $start_time = Time.now
  $time_text = Text.new("Tempo: 0s", x: 10, y: 40, size: 20, color: 'white')

  # Initialize the timer for generating Compound V
  generate_compound_v
  $compound_v_generate_timer = rand(25..45) * 60 # Convert seconds to frames (assuming 60 FPS)
end

def clear_game
  $backgroundImage.remove
  $birds.each(&:remove)
  $ground.remove
  $hugie.remove
  $superhero.remove
  $life_bar_hugie.remove
  $life_bar_superhero.remove
  $compound_v&.remove
  $compound_v_bar&.remove
  $time_text.remove
  $alert_text&.remove
  $alert_text_outline&.remove
end

def create_life_bar(x, y, life, color)
  Rectangle.new(x: x, y: y, width: life * 2.5, height: 25, color: color)
end

def update_game
  update do
    next if $state != GameState::PLAYING

    $hugie.update_position
    $superhero.move_randomly

    check_collision
    check_compound_v_pickup
    update_compound_v_effect
    update_alert
    update_time
    update_characters_state

    # Decrement the timer and generate Compound V if the timer reaches zero
    $compound_v_generate_timer -= 1
    if $compound_v_generate_timer <= 0
      generate_compound_v
      $compound_v_generate_timer = rand(25..45) * 60 # Reset the timer
    end

    debug_positions
  end
end

def check_collision
  if $hugie.image.contains?($superhero.x, $superhero.y) && $superhero.can_attack?
    $superhero.attack($hugie)
  end
end

def handle_game_over
  clear
  $state = GameState::LOSE
  $lose_overlay = LoseOverlay.new
end

def show_alert(message, duration)
  $alert_text = Text.new(message, x: 100, y: 100, size: 30, color: 'yellow', z: 10)
  $alert_text_outline = Text.new(message, x: 98, y: 98, size: 30, color: 'black', z: 9)
  $alert_timer = duration

  # Perform this scaling in another thread because while blocks the main game loop
  Thread.new do
    scale_factor = 1.0
    scale_direction = 1
    while $alert_timer > 0
      scale_factor += 0.05 * scale_direction
      scale_direction *= -1 if scale_factor >= 1.2 || scale_factor <= 1.0
      $alert_text.size = 30 * scale_factor
      $alert_text_outline.size = 30 * scale_factor
      $alert_text.x = (Window.width - $alert_text.width) / 2
      $alert_text_outline.x = (Window.width - $alert_text_outline.width) / 2 - 2
      sleep(0.1)
    end
  end
end

def update_alert
  if $alert_timer > 0
    $alert_timer -= 1
    if $alert_timer == 0
      $alert_text.remove
      $alert_text_outline.remove
      $alert_text = nil
      $alert_text_outline = nil
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

def generate_compound_v
  if $compound_v.nil?
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
  if $compound_v != nil && $hugie.image.contains?($compound_v.x, $compound_v.y)
    $compound_v.remove
    $compound_v = nil
    $compound_v_effect_timer = 900 # 15 seconds at 60 FPS
    $compound_v_bar = create_life_bar(10, 70, ($compound_v_effect_timer / 60)*2, 'purple')
    show_compound_v_alert
  end
end

def update_compound_v_effect
  $compound_v.fall if $compound_v
  if $compound_v_effect_timer > 0
    $compound_v_effect_timer -= 1
    $hugie.become_strong
    $compound_v_bar.width = ($compound_v_effect_timer / 60) * 2
    if $compound_v_effect_timer == 0
      $hugie.become_normal
      $compound_v_bar.remove
      $compound_v_bar = nil
    end
  end
end

def show_compound_v_alert
  show_alert("HUGHIE PEGOU O COMPOSTO V!", 60 * 3)
end

def update_characters_state
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

  if $hugie
    $life_bar_hugie.width = $hugie.life * 2
    $life_bar_hugie.color = 'red' if $hugie.life <= 20
    puts "Hughie perdeu vida! Vida restante: #{$hugie.life}"
    handle_game_over if $hugie.life <= 0
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
  when 'x'
    $hugie.attack($superhero) if $hugie&.can_attack?  
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
  end
end