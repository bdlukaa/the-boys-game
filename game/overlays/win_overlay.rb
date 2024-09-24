require 'ruby2d'
require_relative '../utils'

class WinOverlay
  def initialize
    @texts = []

    Window.set background: 'black'

    win_text = 'VOCÊ GANHOU!'
    continue_text = 'Pressione qualquer tecla para continuar'

    @texts << Text.new(
      win_text,
      size: 80,
      color: Color.new('#8B0000'),
      z: 1
    )

    @texts << Text.new(
      win_text,
      size: 79,
      color: 'red',
      z: 2
    )

    @texts << Text.new(
      win_text,
      size: 78,
      color: 'orange',
      z: 3
    )

    @texts.each do |text|
      center_text(text)
    end

    # get first text position
    first_text = @texts.first

    continue = Text.new(
      continue_text,
      size: 30,
      color: 'white',
      y: first_text.y + first_text.height + 50,
      z: 4
    )
    center_text_h(continue)

    @stars = []

    100.times do
      @stars << Square.new(
        x: rand(Window.width), y: rand(Window.height),
        size: 2,
        color: 'white',
        opacity: rand(0.3..0.8),
        z: 0
      )
    end

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
end

on :key_down do |event|
  next if $state != GameState::WIN
  reset

end