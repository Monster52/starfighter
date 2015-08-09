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

    @meteor_anim = Gosu::Image::load_tiles("media/meteor.png", 25, 25)
    @meteors = Array.new

    @star_anim = Gosu::Image::load_tiles("media/goldCoin1.png", 25, 25)
    @stars = Array.new

    @font = Gosu::Font.new(20)
    @time = 0
  end

  def update
    if Gosu::button_down? Gosu::KbLeft or Gosu::button_down? Gosu::GpLeft then
      @player.turn_left
    end
    if Gosu::button_down? Gosu::KbRight or Gosu::button_down? Gosu::GpRight then
      @player.turn_right
    end
    if Gosu::button_down? Gosu::KbUp or Gosu::button_down? Gosu::GpButton0 then
      @player.accelerate
    end
    if Gosu::button_down? Gosu::KbDown then
      @player.deccelerate
    end
    
    @player.move
    @player.collect_stars(@stars)
    @player.meteor_collide(@meteors)
    @time += 1

    if rand(100) < 4 and @meteors.size < 3 then
      @meteors.push(Meteor.new(@meteor_anim))
    end

    if rand(100) < 4 and @stars.size < 35 then
      @stars.push(Star.new(@star_anim))
    end

    if @player.score == 1000
      exit 
    end

    if @player.life == 0
      exit
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background)
    @player.draw
    @meteors.each { |meteor| meteor.draw }
    @stars.each { |star| star.draw }
    @font.draw( "Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00 )
    @font.draw( "Lives: #{@player.life}", 300, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00 )
    @font.draw( "Time: #{@time}", 150, 10, ZOrder::UI, 1.0, 1.0, 0xff_ffff00 )
  end

  def button_down(id)
    if id == Gosu::KbEscape
      GameState.switch(MenuState.instance)
    end
  end
end

