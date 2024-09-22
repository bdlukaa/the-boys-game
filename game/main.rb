require 'ruby2d'
require_relative 'base/hughie'
require_relative 'base/superhero'
require_relative 'base/essentials'


set title: 'The Boys: The Game', background: 'yellow', resizable: true


show_title


on :key_down do
  hide_title
  $logo.remove
end


hugie = Hugie.new
superhero = SuperHero.new

# Movimentação e Atualização
update do
  # Movimenta o Hugie
  if Window.get(:key, 'left')
    hugie.move_left
  elsif Window.get(:key, 'right')
    hugie.move_right
  elsif Window.get(:key, 'up')
    hugie.move_up
  elsif Window.get(:key, 'down')
    hugie.move_down
  end

 
  superhero.move_randomly

 
  if hugie.image.contains?(superhero.x, superhero.y)
    puts "Game Over! Hugie foi pego pelo SuperHero!"
    close
  end
end

show