# Класс Тайла. Описывается двумя возможными свойствами - пол это (или стены) и окружение другими тайлами
# Число окружения повышается, когда вокруг этого тайла находятся тайлы, которые "полы".
class Tile
  attr_accessor :floor
  attr_accessor :opacity
  attr_accessor :touched

  def initialize
    @touched = 0
    @floor = 0
    @opacity = 0
  end

  # Для свойста floor == 1 - пол, для == 0 - стена
  def print_tile
    case @floor
      when 1
        print "."
      when 0
        print "Û"
    end
  end

end