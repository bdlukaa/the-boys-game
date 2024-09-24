require 'ruby2d'

class PauseOverlay
  def initialize
    $pause_text = Text.new(
      'PAUSE',
      x: (Window.width / 2) - 50, y: (Window.height / 2) - 30,
      size: 40,
      color: 'white'
    )
  end
    
  def hide
    $pause_text.remove if $pause_text   
  end
end