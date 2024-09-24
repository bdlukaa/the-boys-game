class Ground
    attr_accessor :image
  
    def initialize
      @image = Image.new('assets/ground.png', width: 640, height: 100)
      @image.y = GROUND_Y
    end

    def remove
      @image.remove
    end
end