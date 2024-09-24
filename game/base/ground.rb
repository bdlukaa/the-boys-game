class Ground
    attr_accessor :image
  
    def initialize
      @image = Image.new('assets/ground.png', width: Window.width, height: 100)
      @image.y = GROUND_Y
    end
  end