def show_title
  $titleText = Text.new(
    'The Boys: The Game',
    style: 'bold',
    size: 60,
    color: 'black'
  )
  $titleText.x = (Window.width - $titleText.width) / 2
  $titleText.y = (Window.height - $titleText.height) / 2

  $subtitleText = Text.new(
    'Pressione qualquer tecla para continuar',
    style: 'bold',
    size: 20,
    color: 'black'
  )
  $subtitleText.x = (Window.width - $subtitleText.width) / 2
  $subtitleText.y = (Window.height - $subtitleText.height) / 2 + $titleText.height

  $logo = Image.new('assets/logo.png')
  $logo.width = 120
  $logo.height = 100
  $logo.x = 0
  $logo.y = 0
end

def hide_title
  $titleText.remove if $titleText
  $subtitleText.remove if $subtitleText
end