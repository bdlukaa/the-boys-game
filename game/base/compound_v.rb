class CompoundV
  attr_accessor :x, :y, :image

  def initialize
    @image = Image.new('assets/compound_v.png', width: 40, height: 40)
    @x = rand(Window.width - @image.width)
    @y = 0
    update_position
  end

  def remove
    @image.remove
  end

  def fall
    @y += 2  # Faz o Composto V cair mais lentamente
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