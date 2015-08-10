class Meteor
  attr_reader :x, :y

  def initialize
    @image = Gosu::Image.new('media/meteor.png')
    @color = Gosu::Color.new(0xff_B8B8B8)
    @x = rand * 740
    @y = rand * 680
  end

  def draw 
    @image.draw(@x - @image.width / 2.0, @y - @image.height / 2.0,
             ZOrder::Meteors, 1, 1, @color, :add)
  end
end
