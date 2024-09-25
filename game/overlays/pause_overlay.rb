require 'ruby2d'
require_relative '../utils'

class PauseOverlay
  attr_accessor :quit_text, :resume_text

  def initialize
    @background = Rectangle.new(
      x: 0, y: 0,
      width: Window.width, height: Window.height,
      color: [0, 0, 0, 0.7],
      z: 10
    )

    @pause_text = create_text('PAUSE', (Window.height / 2) - 100, 40)
    @resume_text = create_text('Resume', (Window.height / 2) - 30, 30)
    @quit_text = create_text('Quit', (Window.height / 2) + 30, 30)

    @pause_visible = false
  end

  def show
    [@background, @pause_text, @resume_text, @quit_text].each(&:add)
    @pause_visible = true
  end

  def hide
    [@background, @pause_text, @resume_text, @quit_text].each(&:remove)
    @pause_visible = false
  end

  private

  def create_text(content, y, size)
    text = Text.new(
      content,
      x: (Window.width / 2) - 50, y: y,
      size: size,
      color: 'white',
      z: 20
    )
    center_text_h(text)
    text
  end
end

def toggle_pause
  $state = $state == GameState::PAUSED ? GameState::PLAYING : GameState::PAUSED
  if $state == GameState::PAUSED
    $pause_overlay = PauseOverlay.new
  else
    $pause_overlay&.hide
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

  update_text_size($pause_overlay.resume_text, event)
  update_text_size($pause_overlay.quit_text, event)
end

def update_text_size(text, event)
  text.size = text.contains?(event.x, event.y) ? 35 : 30
  center_text_h(text)
end
