class Hughie
  attr_accessor :x, :y, :image, :velocity_y, :life, :attack_power, :speed, :last_attack_time, :state

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

  def move_left
    @x = [@x - @speed, 0].max
    change_state(:walking)
    update_position
  end

  def move_right
    @x = [@x + @speed, Window.width - @image.width].min
    change_state(:walking)
    update_position
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
    @idle_image = load_sprite('assets/hughie_idle.png', 80, 80, 300, true)
    @attack_image = load_sprite('assets/hughie_attack.png', 80, 80, 100, false)
    @jump_image = load_sprite('assets/hughie_jump.png', 80, 80, 300, true)
    @hurt_image = load_sprite('assets/hughie_hurt.png', 80, 80, 300, false)
    @walk_image = load_sprite('assets/hughie_walk.png', 80, 80, 200, true)
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
    @attack_power = 5
    @speed = 3
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
end
