require 'ruby2d'

class LoseOverlay
  def initialize
    setup_window
    create_texts
    center_texts
    create_stars
    @visible = true
  end

  def show
    @texts.each(&:add)
    @stars.each(&:add)
    @visible = true
  end

  def hide
    @texts.each(&:remove)
    @stars.each(&:remove)
    @visible = false
  end

  private

  def setup_window
    Window.set background: 'black'
  end

  def create_texts
    main_text = 'VOCÊ PERDEU :/'
    @subtitle_text = Text.new('Pressione qualquer tecla para voltar', size: 30, color: 'white', z: 4)
    @texts = [
      Text.new(main_text, size: 100, color: Color.new('#8B0000'), z: 1),
    ]
  end

  def center_texts
    main_texts = @texts[0..2]

    main_texts.each { |text| center_text(text) }

    @subtitle_text.x = (Window.width - @subtitle_text.width) / 2
    @subtitle_text.y = (Window.height + main_texts.first.height) / 2 + 20
  end

  def create_stars
    @stars = Array.new(100) do
      Square.new(
        x: rand(Window.width), y: rand(Window.height),
        size: 2, color: 'white',
        opacity: rand(0.3..0.8), z: 0
      )
    end
  end

  def center_text(text)
    text.x = (Window.width - text.width) / 2
    text.y = (Window.height - text.height) / 2
  end
end
