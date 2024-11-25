require 'ruby2d'
require_relative '../utils'

class WinOverlay
  def initialize
    @texts = []
    @stars = []

    setup_window
    create_texts
    create_stars

    @visible = true
  end

  def show
    @texts.each(&:add)
    @stars.each(&:add)
    @visible = true
  end

  def remove
    @texts.each(&:remove)
    @stars.each(&:remove)
    @visible = false
  end

  private

  def setup_window
    Window.set background: 'black'
  end

  def create_texts
    win_text = 'VOCÊ GANHOU!'
    continue_text = 'Pressione ESPAÇO para continuar'

    @texts << create_text(win_text, 80, '#8B0000', 1)
    @texts << create_text(win_text, 79, 'red', 2)
    @texts << create_text(win_text, 78, 'orange', 3)

    @texts.each { |text| center_text(text) }

    first_text = @texts.first
    continue = Text.new(
      continue_text,
      size: 30,
      color: 'white',
      y: first_text.y + first_text.height + 50,
      z: 4
    )
    center_text_h(continue)
  end

  def create_text(content, size, color, z)
    Text.new(
      content,
      size: size,
      color: Color.new(color),
      z: z
    )
  end

  def create_stars
    100.times do
      @stars << Square.new(
        x: rand(Window.width), y: rand(Window.height),
        size: 2,
        color: 'white',
        opacity: rand(0.3..0.8),
        z: 0
      )
    end
  end
end

on :key_down do |event|
  next if $state != GameState::WIN
  if event.key == 'space'
    reset
  end
end
