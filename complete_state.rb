require 'singleton'
require_relative 'play_state'

class CompleteState < GameState
  include Singleton
  attr_accessor :play_state

  def initialize
    @message = Gosu::Image.from_text(
      $window, "You Completed the Mission",
      Gosu.default_font_name, 80)
    @final_time = Gosu::Image.from_text(
      $window, "Your final time was #{$time}",
      Gosu.default_font_name, 50)
    @info = Gosu::Image.from_text(
      $window, "Q = Quit, N = New Game",
      Gosu.default_font_name, 30)
    @music = Gosu::Song.new("media/Jingle_Win_00.wav")
  end

  def draw
    @music.play
    @message.draw(
      $window.width / 2 - @message.width / 2,
      $window.height / 2 - @message.height / 2,
      10)
    @final_time.draw(
      $window.width / 2 - @final_time.width / 2,
      $window.height / 2 - @final_time.height / 2 + 100,
      10)
    @info.draw(
      $window.width / 2 - @info.width / 2,
      $window.height / 2 - @info.height / 2 + 200,
      10)
  end

  def button_down(id)
    $window.close if id == Gosu::KbQ
      if id == Gosu::KbN
        @play_state = PlayState.new
      GameState.switch(@play_state)
    end
  end
end

