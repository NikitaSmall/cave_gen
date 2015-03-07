# базовый класс для объектов, которые помещены на карту
class Creature
  attr_accessor :x_coord
  attr_accessor :y_coord

  def initialize(y_coord, x_coord)
    @y_coord = y_coord
    @x_coord = x_coord
  end

end

class Hero < Creature
  attr_accessor :x_coord
  attr_accessor :y_coord
  attr_accessor :name
  attr_accessor :symbol

  def initialize(y_coord, x_coord, name)
    @y_coord = y_coord
    @x_coord = x_coord
    @name = name
    @symbol = "@"
  end

end