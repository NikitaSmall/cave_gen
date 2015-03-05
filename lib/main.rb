# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Tile
  attr_accessor :floor
  attr_accessor :opacity

  def initialize
    @floor = 0;
    @opacity = 0;
  end

end

class Map

  def initialize(height, width)
    @height = height
    @width = width

    rows, cols = @width,@height
    @grid = Array.new(rows) { Array.new(cols) }

    @grid.each do |y|
      y.each do |x|
        x = Tile.new
      end
    end
  end

  def show_map
    @grid.each do |y|
      y.each do |x|
        print "."
      end
      print "\n"
    end
  end

end

@map = Map.new(20, 20)

@map.show_map

