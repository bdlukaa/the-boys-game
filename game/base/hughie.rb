class Hugie
  attr_accessor :x, :y, :image

  def initialize
    @image = Image.new('assets/hugie.png', width: 80, height: 80)
    @x = Window.width / 2
    @y = Window.height / 2
    update_position
  end

  def move_left
    @x -= 5
    update_position
  end

  def move_right
    @x += 5
    update_position
  end

  def move_up
    @y -= 5
    update_position
  end

  def move_down
    @y += 5
    update_position
  end

  def update_position
    @image.x = @x
    @image.y = @y
  end
end