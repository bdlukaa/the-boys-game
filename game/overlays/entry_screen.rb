require 'ruby2d'

class EntryScreen
  def initialize
    @titleText = Text.new(
      'The Boys: The Game',
      style: 'bold',
      size: 60,
      color: 'black'
    )
    @titleText.x = (Window.width - @titleText.width) / 2
    @titleText.y = (Window.height - @titleText.height) / 2

    @subtitleText = Text.new(
      'Pressione qualquer tecla para continuar',
      style: 'bold',
      size: 20,
      color: 'black'
    )
    @subtitleText.x = (Window.width - @subtitleText.width) / 2
    @subtitleText.y = (Window.height - @titleText.height) / 2 + @titleText.height
  end

  def remove
    @titleText.remove
    @subtitleText.remove
  end
end