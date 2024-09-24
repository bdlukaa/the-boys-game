require 'ruby2d'

class WinOverlay
  def initialize
    @texts = []

    Window.set background: 'black'

    center_x = (Window.width / 2) - 250
    center_y = (Window.height / 2) - 50

    @texts << Text.new(
      'YOU WIN!',
      x: center_x, y: center_y,
      size: 100,
      color: Color.new('#8B0000'),
      z: 1
    )

    @texts << Text.new(
      'YOU WIN!',
      x: center_x + 5, y: center_y + 5,
      size: 100,
      color: 'red',
      z: 2
    )

    @texts << Text.new(
      'YOU WIN!',
      x: center_x + 10, y: center_y + 10,
      size: 100,
      color: 'orange',
      z: 3
    )

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
  end

  def remove
    @texts.each(&:remove)
    @stars.each(&:remove)
  end
end
