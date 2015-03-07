class BaseTile
  attr_accessor :x
  attr_accessor :y
  attr_accessor :opacity
  attr_accessor :touched
  attr_accessor :symbol

  def initialize(y, x, opacity = 0)
    @y = y
    @x = x
    @touched = 0
    @opacity = opacity
    @symbol = " "
  end

  def print_tile
    print @symbol
  end

  def is_floor?
    return false
  end

end

# Класс Тайла. Описывается двумя возможными свойствами - пол это (или стены) и окружение другими тайлами
# Число окружения повышается, когда вокруг этого тайла находятся тайлы, которые "полы".
class Floor < BaseTile

  def initialize(y, x, opacity = 0)
    super(y, x, opacity)
    @symbol = "."
  end

  def is_floor?
    return true
  end

end

class Wall < BaseTile

  def initialize(y, x, opacity = 0)
    super(y, x, opacity)
    @symbol = "Û"
  end
end