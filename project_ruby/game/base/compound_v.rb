class CompoundV
  attr_accessor :x, :y, :image

  def initialize
    @image = Image.new('assets/compound_v.png', width: 80, height: 80)
    @x = rand(Window.width - @image.width)
    @y = 0
    update_position
    fall
  end

  def remove
    @image.remove
  end

  def fall
    @y += 2
    update_position
  end

  def update_position
    @image.x = @x
    @image.y = @y
  end

  def off_screen?
    @y > Window.height
  end
end