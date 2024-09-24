class Hugie
  attr_accessor :x, :y, :image, :velocity_y, :life, :attack_power, :speed, :last_attack_time

  def initialize
    @image = Image.new('assets/hugie.png', width: 80, height: 80)
    @x = Window.width / 2
    @y = GROUND_Y - @image.height
    @velocity_y = 0
    @life = 100
    @attack_power = 5  # Dano reduzido
    @speed = 3  # Velocidade reduzida
    @last_attack_time = Time.now
    @on_ground = true
    update_position
  end

  def move_left
    @x = [@x - @speed, 0].max
    update_position
  end

  def move_right
    @x = [@x + @speed, Window.width - @image.width].min
    update_position
  end

  def jump
    if on_ground?
      @velocity_y = -15  # Ajuste a velocidade do pulo para um valor mais apropriado
      @on_ground = false
    end
  end

  def on_ground?
    @y >= GROUND_Y - @image.height
  end

  def update_position
    @velocity_y += 1 # Simula a gravidade
    @y += @velocity_y
    if on_ground?
      @y = GROUND_Y - @image.height
      @velocity_y = 0
      @on_ground = true
    end
    @image.x = @x
    @image.y = @y
  end

  def lose_life(amount)
    @life -= amount
    @life = 0 if @life < 0
  end

  def attack(superhero)
    if can_attack? && close_to?(superhero)
      superhero.lose_life(@attack_power)
      @last_attack_time = Time.now
    end
  end

  def can_attack?
    Time.now - @last_attack_time > 1  # Cooldown de 1 segundo
  end

  def close_to?(superhero)
    (@x - superhero.x).abs < 50  # Verifica se a distância é menor que 50 pixels
  end
end