class Hugie
  attr_accessor :x, :y, :image, :velocity_y, :life, :attack_power, :speed, :last_attack_time, :state

  def initialize
    # Carregar as animações, mas não adicioná-las à tela ainda
    @idle_image = Sprite.new(
      'assets/hugie_idle.png',
      width: 80, height: 80, time: 300, loop: true
    )
    @idle_image.remove # Não mostrar a animação no início

    @attack_image = Sprite.new(
      'assets/hugie_attack.png',
      width: 80, height: 80, time: 100, loop: false
    )
    @attack_image.remove

    @jump_image = Sprite.new(
      'assets/hugie_jump.png',
      width: 80, height: 80, time: 300, loop: true
    )
    @jump_image.remove

    @hurt_image = Sprite.new(
      'assets/hugie_hurt.png',
      width: 80, height: 80, time: 300, loop: false
    )
    @hurt_image.remove

    @walk_image = Sprite.new(
      'assets/hugie_walk.png',
      width: 80, height: 80, time: 200, loop: true
    )
    @walk_image.remove

    @image = @idle_image # Definir animação inicial, mas ainda não exibi-la
    @x = Window.width / 2
    @y = GROUND_Y - @image.height
    @velocity_y = 0
    @life = 100
    @attack_power = 5
    @speed = 3
    @last_attack_time = Time.now
    @on_ground = true
    @state = :idle
    update_position
  end

  # Exibir Hugie
  def show
    @image.add
  end

  # Ocultar Hugie
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
    if on_ground?
      @velocity_y = -15
      @on_ground = false
      change_state(:jump)
    end
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
    @life -= amount
    @life = 0 if @life < 0
    change_state(:hurt)
  end

  def attack(superhero = nil)
    if can_attack?
      if superhero && close_to?(superhero)
        superhero.lose_life(@attack_power)
      end
      @last_attack_time = Time.now
      change_state(:attack)
    end
  end

  def can_attack?
    Time.now - @last_attack_time > 0.4
  end

  def close_to?(superhero)
    (@x - superhero.x).abs < 50
  end

  def change_state(new_state)
    return if @state == new_state

    @image.remove # Remover a animação anterior
    @state = new_state

    case @state
    when :idle
      @image = @idle_image
    when :attack
      @image = @attack_image
      @image.play { change_state(:idle) }
    when :jump
      @image = @jump_image
    when :hurt
      @image = @hurt_image
      @image.play { change_state(:idle) }
    when :walking
      @image = @walk_image
    end

    @image.x = @x
    @image.y = @y
    @image.add # Adicionar a nova animação à tela
  end
end
