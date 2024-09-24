require 'ruby2d'

require_relative '../utils'

class PauseOverlay

  attr_accessor :quit_text
  attr_accessor :resume_text

  def initialize
    @background = Rectangle.new(
      x: 0, y: 0,
      width: Window.width, height: Window.height,
      color: [0, 0, 0, 0.7],
      z: 10
    )

    @pause_text = Text.new(
      'PAUSE',
      x: (Window.width / 2) - 50, y: (Window.height / 2) - 100,
      size: 40,
      color: 'white',
      z: 20
    )
    center_text_h(@pause_text)

    @resume_text = Text.new(
      'Resume',
      x: (Window.width / 2) - 50, y: (Window.height / 2) - 30,
      size: 30,
      color: 'white',
      z: 20
    )
    center_text_h(@resume_text)

    @quit_text = Text.new(
      'Quit',
      x: (Window.width / 2) - 50, y: (Window.height / 2) + 30,
      size: 30,
      color: 'white',
      z: 20
    )
    center_text_h(@quit_text)

    @pause_visible = false
  end

  def show
    @background.add
    @pause_text.add
    @resume_text.add
    @quit_text.add
    @pause_visible = true
  end

  def hide
    @background.remove
    @pause_text.remove
    @resume_text.remove
    @quit_text.remove
    @pause_visible = false
  end

end

def toggle_pause
  $state = $state == GameState::PAUSED ? GameState::PLAYING : GameState::PAUSED
  if $state == GameState::PAUSED
    $pause_overlay = PauseOverlay.new
  else
    $pause_overlay.hide if $pause_overlay
  end
end

on :mouse_down do |event|
  next if $state != GameState::PAUSED 

  if $pause_overlay.resume_text.contains?(event.x, event.y)
    toggle_pause
  elsif $pause_overlay.quit_text.contains?(event.x, event.y)
    reset
  end
end

on :mouse_move do |event|
  next if $state != GameState::PAUSED

  if $pause_overlay.resume_text.contains?(event.x, event.y)
    $pause_overlay.resume_text.size = 35
  else
    $pause_overlay.resume_text.size = 30
  end

  if $pause_overlay.quit_text.contains?(event.x, event.y)
    $pause_overlay.quit_text.size = 35
  else
    $pause_overlay.quit_text.size = 30
  end

  center_text_h($pause_overlay.resume_text)
  center_text_h($pause_overlay.quit_text)
end