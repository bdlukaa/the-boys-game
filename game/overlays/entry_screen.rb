require 'ruby2d'

class EntryScreen
  def initialize
    @sky = Image.new('assets/background/sky.png', width: Window.width, height: Window.height)
    setup_title_text
    setup_subtitle_text
  end

  def show
    @sky.add
    @title_text.add
    @subtitle_text.add
  end

  def remove
    @sky.remove
    @title_text.remove
    @subtitle_text.remove
  end

  private

  def setup_title_text
    @title_text = Text.new(
      'The Boys: The Game',
      style: 'bold',
      size: 60,
      color: 'black'
    )
    @title_text.x = (Window.width - @title_text.width) / 2
    @title_text.y = (Window.height - @title_text.height) / 2
  end

  def setup_subtitle_text
    @subtitle_text = Text.new(
      'Pressione qualquer tecla para continuar',
      style: 'bold',
      size: 20,
      color: 'black'
    )
    @subtitle_text.x = (Window.width - @subtitle_text.width) / 2
    @subtitle_text.y = (Window.height - @title_text.height) / 2 + @title_text.height
  end
end