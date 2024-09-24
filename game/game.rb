require_relative 'state'
require_relative 'base/hughie'
require_relative 'base/superhero'
require_relative 'base/ground'
require_relative 'base/compound_v'
require_relative 'overlays/lose_overlay'

def start_game
  $backgroundImage = Image.new('assets/background.png', width: Window.width, height: Window.height)

  # Adiciona a imagem do chão
  $ground = Ground.new

  # Instancia os objetos do jogo
  $hugie = Hugie.new
  $superhero = SuperHero.new

  # Adiciona a barra de vida do Hugie
  $life_bar_hugie = Rectangle.new(
    x: 10, y: 10,
    width: $hugie.life * 2, height: 20,
    color: 'green'
  )

  # Adiciona a barra de vida do SuperHero
  $life_bar_superhero = Rectangle.new(
    x: Window.width - 210, y: 10,
    width: $superhero.life * 2, height: 20,
    color: 'blue'
  )

  # Variável para armazenar o Composto V
  $compound_v = nil
  $compound_v_timer = 0

  # Variável para o alerta
  $alert_text = nil
  $alert_timer = 0

  # Variável para o tempo de jogo
  $start_time = Time.now
  $time_text = Text.new(
    "Tempo: 0s",
    x: 10, y: 40,
    size: 20,
    color: 'white'
  )

  update do
    next if $state != GameState::PLAYING

    # Atualiza a posição do Hugie
    $hugie.update_position

    # Movimenta o SuperHero aleatoriamente
    $superhero.move_randomly

    # Verifica colisão entre Hugie e SuperHero
    if $hugie.image.contains?($superhero.x, $superhero.y)
      if $superhero.can_attack?
        $superhero.attack($hugie)
        $life_bar_hugie.width = $hugie.life * 2
        $life_bar_hugie.color = 'red' if $hugie.life <= 20
        puts "Hugie perdeu vida! Vida restante: #{$hugie.life}"
        if $hugie.life <= 0
          clear
          $state = GameState::LOSE
          $lose_overlay = LoseOverlay.new
        end
      end
    end

    # Gera o Composto V aleatoriamente
    if $compound_v.nil? && $compound_v_timer <= 0
      $compound_v = CompoundV.new
      $compound_v_timer = rand(1800..3600)  # Entre 30 e 60 segundos (60 frames por segundo)
    end

    # Movimenta o Composto V
    if $compound_v
      $compound_v.fall

      # Verifica se o Hugie pegou o Composto V
      if $hugie.image.contains?($compound_v.x, $compound_v.y)
        $hugie.velocity_y -= 5  # Aumenta a velocidade do Hugie
        $hugie.attack_power = 20  # Aumenta o poder de ataque do Hugie
        $compound_v = nil  # Remove o Composto V
        puts "Hugie pegou o Composto V! Agora ele está mais forte e rápido!"

        # Exibe o alerta na tela
        $alert_text = Text.new(
          'HUGIE PEGOU O COMPOSTO V!!!',
          x: 100, y: 100,
          size: 30,
          color: 'yellow'
        )
        $alert_timer = 60  # Exibe o alerta por 60 frames (~1 segundo)
      end

      # Remove o Composto V se ele sair da tela
      $compound_v = nil if $compound_v&.off_screen?
    end

    # Remove o alerta após o tempo definido
    if $alert_timer > 0
      $alert_timer -= 1
      if $alert_timer == 0
        $alert_text.remove
        $alert_text = nil
      end
    end

    # Decrementa o timer do Composto V
    $compound_v_timer -= 1 if $compound_v_timer > 0

    # Atualiza o tempo de jogo
    elapsed_time = (Time.now - $start_time).to_i
    $time_text.text = "Tempo: #{elapsed_time}s"

    # Debugging positions
    puts "Hugie position: #{$hugie.x}, #{$hugie.y}"
    puts "SuperHero position: #{$superhero.x}, #{$superhero.y}"
  end
end