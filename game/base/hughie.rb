class Hughie
  attr_accessor :x, :y, :image, :velocity_y, :life, :attack_power, :speed, :last_attack_time, :state

  DEFAULT_SPEED = 3
  DEFAULT_ATTACK_POWER = 5
  DEFAULT_HEIGHT = 160
  DEFAULT_WIDTH = 160

  def initialize
    load_animations
    set_initial_state
    update_position
  end

  def show
    @image.add
  end

  def hide
    @image.remove
  end

  def remove
    @image.remove
  end


  @flip = :none
  def move_left
    @x = [@x - @speed, 0].max
    change_state(:walking)
    flip_sprite_horizontally(true)
    update_position
  end

  def move_right
    @x = [@x + @speed, Window.width - @image.width].min
    change_state(:walking)
    flip_sprite_horizontally(false)
    update_position
  end

  def flip_sprite_horizontally(flip)
    if flip
      if flip == :horizontal
        @image.flip_sprite(nil)
        @flip = :none
      else
        @image.flip_sprite(:horizontal)
        @flip = :horizontal
      end
    else
      @image.flip_sprite(nil)
      @flip = :none
    end
  end

  def jump
    return unless on_ground?

    @velocity_y = -15
    @on_ground = false
    change_state(:jump)
  end

  def on_ground?
    @y >= GROUND_Y - @image.height
  end

  def update_position
    @velocity_y += 1
    @y += @velocity_y
    if on_ground?
      @y = GROUND_Y - @image.height
      @velocity_y = 0
      @on_ground = true
      change_state(:idle) if @state == :jump
    end
    @image.x = @x
    @image.y = @y
  end

  def lose_life(amount)
    @life = [@life - amount, 0].max
    change_state(:hurt)
  end

  def attack(superhero = nil)
    return unless can_attack?

    superhero&.lose_life(@attack_power) if close_to?(superhero)
    @last_attack_time = Time.now
    change_state(:attack)
  end

  def can_attack?
    Time.now - @last_attack_time > 0.4
  end

  def close_to?(superhero)
    (@x - superhero.x).abs < 50
  end

  def load_animations
    @idle_image = load_sprite('assets/hughie/hughie_idle.png', DEFAULT_WIDTH, DEFAULT_HEIGHT, 300, true)
    @attack_image = load_sprite('assets/hughie/hughie_attack.png', DEFAULT_WIDTH, DEFAULT_HEIGHT, 100, false)
    @jump_image = load_sprite('assets/hughie/hughie_jump.png', DEFAULT_WIDTH, DEFAULT_HEIGHT, 300, true)
    @hurt_image = load_sprite('assets/hughie/hughie_hurt.png', DEFAULT_WIDTH, DEFAULT_HEIGHT, 300, false)
    @walk_image = load_sprite('assets/hughie/hughie_walk.png', DEFAULT_WIDTH, DEFAULT_HEIGHT, 200, true)
  end

  def load_sprite(file, width, height, time, loop)
    sprite = Sprite.new(file, width: width, height: height, time: time, loop: loop)
    sprite.remove
    sprite
  end

  def set_initial_state
    @image = @idle_image
    @x = Window.width / 2
    @y = GROUND_Y - @image.height
    @velocity_y = 0
    @life = 100
    @attack_power = DEFAULT_ATTACK_POWER
    @speed = DEFAULT_SPEED
    @last_attack_time = Time.now
    @on_ground = true
    @state = :idle
  end

  def change_state(new_state)
    return if @state == new_state

    @image.remove
    @state = new_state

    @image = case @state
             when :idle then @idle_image
             when :attack then @attack_image
             when :jump then @jump_image
             when :hurt then @hurt_image
             when :walking then @walk_image
             end

    @image.x = @x
    @image.y = @y
    @image.add
    @image.play { change_state(:idle) } if [:attack, :hurt].include?(@state)
  end

  def become_strong
    @attack_power = DEFAULT_ATTACK_POWER * 2.5
    @speed = DEFAULT_SPEED * 2.5
    @image.height = DEFAULT_HEIGHT * 1.5
    @image.width = DEFAULT_WIDTH * 1.5
  end

  def become_normal
    @attack_power = DEFAULT_ATTACK_POWER
    @speed = DEFAULT_SPEED
    @image.height = DEFAULT_HEIGHT
    @image.width = DEFAULT_WIDTH
  end

  def receive_damage(amount)
    if @attack_power > DEFAULT_ATTACK_POWER
      amount /= 2
    end
    lose_life(amount)
  end
end
