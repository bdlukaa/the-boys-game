require 'ruby2d'

class LoseOverlay
  def initialize
    @texts = []

    Window.set background: 'black'

    text = 'YOU LOST!'

    @texts << Text.new(
      text,
      size: 100,
      color: Color.new('#8B0000'),
      z: 1
    )

    @texts << Text.new(
      text,
      size: 98,
      color: 'red',
      z: 2
    )

    @texts << Text.new(
      text,
      size: 96,
      color: 'orange',
      z: 3
    )

    @texts.each do |text|
      center_text(text)
    end

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

  def hide
    @texts.each(&:remove)
    @stars.each(&:remove)
    @visible = false
  end
end
