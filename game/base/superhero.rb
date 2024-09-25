class SuperHero
  attr_accessor :x, :y, :image, :life, :attack_power, :speed, :last_attack_time, :direction, :direction_timer

  def initialize
    @image = Image.new('assets/superhero.png', width: 80, height: 80)
    @x = rand(Window.width - @image.width)
    @y = GROUND_Y - @image.height
    @life = 100
    @attack_power = 5
    @speed = 3
    @last_attack_time = Time.now
    @direction = [:left, :right].sample
    @direction_timer = rand(60..120)
    update_position
  end

  def remove
    @image.remove
  end

  def move_randomly
    change_direction if @direction_timer <= 0

    move
    @direction_timer -= 1
    update_position
  end

  def lose_life(amount)
    @life = [@life - amount, 0].max
  end

  def attack(target)
    if can_attack? && close_to?(target)
      target.lose_life(@attack_power)
      @last_attack_time = Time.now
    end
  end

  private

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
    when :right
      @x = [@x + @speed, Window.width - @image.width].min
    end
  end

  def can_attack?
    Time.now - @last_attack_time > 1
  end

  def close_to?(target)
    (@x - target.x).abs < 50
  end
end