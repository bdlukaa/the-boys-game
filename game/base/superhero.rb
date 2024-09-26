$character_height = 160 * 2.5
$character_width = 160 * 2.5

class SuperHero
  attr_accessor :x, :y, :image, :life, :attack_power, :speed, :last_attack_time, :direction, :direction_timer, :state

  DEFAULT_SPEED = 8
  DEFAULT_ATTACK_POWER = 10
  MAX_SPEED = 20       # Velocidade máxima
  ACCELERATION = 0.1   # Valor de aceleração
  ATTACK_COOLDOWN = 1

  def initialize
    load_animations
    set_initial_state
    update_position
  end

  # Método para aumentar a velocidade até o limite
  def accelerate
    @speed = [@speed + ACCELERATION, MAX_SPEED].min
  end

  def remove
    @image.remove
  end

  def move_randomly
    return unless @state == :idle || @state == :walking
    change_direction if @direction_timer <= 0 || @x <= 0 || @x >= Window.width - @image.width

    move
    accelerate  # Acelera a cada movimento
    @direction_timer -= 1
    update_position
  end

  def lose_life(amount)
    @life = [@life - amount, 0].max
    change_state(:hurt)
  end

  def attack(target)
    if can_attack? && close_to?(target)
      target.receive_damage(@attack_power)
      @last_attack_time = Time.now
      change_state(:attack)
    end
  end

  def update_position
    @image.x = @x
    @image.y = @y
  end

  def change_direction
    @direction = [:left, :right].sample
    @direction_timer = rand(60..120)
  end

  def move
    case @direction
    when :left
      @x = [@x - @speed, 0].max
      change_state(:walking)
      flip_sprite_horizontally(true)
    when :right
      @x = [@x + @speed, Window.width - @image.width].min
      change_state(:walking)
      flip_sprite_horizontally(false)
    end
    update_position
  end

  def can_attack?
    Time.now - @last_attack_time > ATTACK_COOLDOWN
  end

  def close_to?(target)
    (@x - target.x).abs < 50
  end

  def load_animations
    @animations = {
      idle: load_sprite('assets/hughie/hughie_idle.png', $character_width, $character_height, 300, true),
      attack: load_sprite('assets/hughie/hughie_attack.png', $character_width, $character_height, 100, false),
      hurt: load_sprite('assets/hughie/hughie_hurt.png', $character_width, $character_height, 300, false),
      walk: load_sprite('assets/hughie/hughie_walk.png', $character_width, $character_height, 200, true)
    }
  end

  def load_sprite(file, width, height, time, loop)
    sprite = Sprite.new(file, width: width, height: height, time: time, loop: loop, color: 'blue')
    sprite.remove
    sprite
  end

  def set_initial_state
    @image = @animations[:idle]
    @x = rand(Window.width - @image.width)
    @y = GROUND_Y - @image.height
    @life = 100
    @attack_power = DEFAULT_ATTACK_POWER
    @speed = DEFAULT_SPEED
    @last_attack_time = Time.now
    @direction = [:left, :right].sample
    @direction_timer = rand(60..120)
    @state = :idle
  end

  def change_state(new_state)
    return if @state == new_state

    @image.remove
    @state = new_state

    @image = @animations[@state] || @animations[:idle]
    update_position
    @image.add
    @image.play { change_state(:idle) } if [:attack, :hurt].include?(@state)
  end

  def flip_sprite_horizontally(flip)
    flip ? @image.flip_sprite(:horizontal) : @image.flip_sprite(nil)
  end
end
