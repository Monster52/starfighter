require_relative 'player'
require_relative 'star'
require_relative 'meteor'

module ZOrder
  Background, Stars, Meteors, Player, UI = *0..4
end

class PlayState < GameState 
  def initialize
    @background_image = Gosu::Image.new("media/space_bg.png", :tileable => true)

    @player = Player.new
    @player.warp(420, 340)

    @meteor = Meteor.new 
    @meteors = Array.new

    @star = Star.new
    @stars = Array.new

    @font = Gosu::Font.new(20)
    $time = 0
  end

  def update
    if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::KbA then
      @player.turn_left
    end
    if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::KbD then
      @player.turn_right
    end
    if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::KbW then
      @player.accelerate
    end
    if Gosu::button_down? Gosu::KbDown or Gosu::button_down? Gosu::KbS then
      @player.deccelerate
    end
    
    @player.move
    @player.collect_stars(@stars)
    @player.meteor_collide(@meteors)
    $time += 1

    if rand(100) < 4 and @meteors.size < 5 then
      @meteors.push(Meteor.new)
    end

    if rand(100) < 4 and @stars.size < 35 then
      @stars.push(Star.new)
    end

    if @player.score == 1000
      GameState.switch(CompleteState.instance)
    end

    if @player.life == 0
      GameState.switch(OutOfLivesState.instance)
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @player.draw
    @meteors.each { |meteor| meteor.draw }
    @stars.each { |star| star.draw }
    @font.draw( "Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00 )
    @font.draw( "Lives: #{@player.life}", 300, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00 )
    @font.draw( "Time: #{$time}", 150, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00 )
  end

  def button_down(id)
    if id == Gosu::KbEscape
      GameState.switch(MenuState.instance)
    end
  end
end


