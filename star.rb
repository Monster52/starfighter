class Star
  attr_reader :x, :y

  def initialize
    @image = Gosu::Image.new('media/goldCoin1.png')
    @color = Gosu::Color.new(0xff_ffffff)
    @x = rand * 840
    @y = rand * 680
  end

  def draw
    @image.draw(@x - @image.width / 2.0, @y - @image.height / 2.0,
             ZOrder::Stars, 1, 1, @color, :add)
  end
end

