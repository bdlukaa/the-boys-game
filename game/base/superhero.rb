class SuperHero
  attr_accessor :x, :y, :image

  def initialize
    @image = Image.new('assets/superhero.png', width: 80, height: 80)
    @x = rand(Window.width - @image.width)
    @y = rand(Window.height - @image.height)
    update_position
  end

  def move_randomly
    @x += rand(-2..2)
    @y += rand(-2..2)
    keep_in_bounds
    update_position
  end

  def keep_in_bounds
    @x = [0, [@x, Window.width - @image.width].min].max
    @y = [0, [@y, Window.height - @image.height].min].max
  end

  def update_position
    @image.x = @x
    @image.y = @y
  end
end