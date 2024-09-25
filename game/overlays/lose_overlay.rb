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
    text = 'VOCÊ PERDEU :/'
    @texts = [
      Text.new(text, size: 100, color: Color.new('#8B0000'), z: 1),
      Text.new(text, size: 98, color: 'red', z: 2),
      Text.new(text, size: 96, color: 'orange', z: 3)
    ]
  end

  def center_texts
    @texts.each { |text| center_text(text) }
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
