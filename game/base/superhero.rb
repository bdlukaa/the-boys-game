class SuperHero
  attr_accessor :x, :y, :image, :life, :attack_power, :speed, :last_attack_time, :direction, :direction_timer

  def initialize
    @image = Image.new('assets/superhero.png', width: 80, height: 80)
    @x = rand(Window.width - @image.width)
    @y = GROUND_Y - @image.height
    @life = 200
    @attack_power = 5
    @speed = 3
    @last_attack_time = Time.now
    @direction = [:left, :right].sample
    @direction_timer = rand(60..120)  # Muda de direção a cada 1 a 2 segundos
    update_position
  end

  def move_randomly
    if @direction_timer <= 0
      @direction = [:left, :right].sample
      @direction_timer = rand(60..120)
    end

    case @direction
    when :left
      @x = [@x - @speed, 0].max
    when :right
      @x = [@x + @speed, Window.width - @image.width].min
    end

    @direction_timer -= 1
    update_position
  end

  def update_position
    @image.x = @x
    @image.y = @y
  end

  def lose_life(amount)
    @life -= amount
    @life = 0 if @life < 0
  end

  def attack(hugie)
    if can_attack? && close_to?(hugie)
      hugie.lose_life(@attack_power)
      @last_attack_time = Time.now
    end
  end

  def can_attack?
    Time.now - @last_attack_time > 1  # Cooldown de 1 segundo
  end

  def close_to?(hugie)
    (@x - hugie.x).abs < 50  # Verifica se a distância é menor que 50 pixels
  end
end