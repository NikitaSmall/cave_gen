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

  def print_tile
    case @floor
      when 1
        print "."
      when 0
        print "Û"
    end
  end

end

class Map

  def initialize(height, width)
    @height = height
    @width = width
    @stop = 0

    rows, cols = @width,@height
    @grid = Array.new(rows) { Array.new(cols) {Tile.new} }
  end

  def show_map
    @grid.each do |y|
      y.each do |x|
        x.print_tile
      end
      print "\n"
    end
  end

  def generate_map
    @curr_point = get_start_point

    15.times do
      check_point_to_floor(@curr_point[0], @curr_point[1])
      @curr_point = get_next_point(@curr_point[0], @curr_point[1])
    end

  end

  def get_start_point
    @rand_point = [rand(1..@height-2), rand(1..@width-2)]
  end

  def check_point_to_floor(y_coord, x_coord)
    (y_coord-1..y_coord+1).each do |y|
      (x_coord-1..x_coord+1).each do |x|
        if @grid[y][x].floor == 1
          @grid[y_coord][x_coord].opacity += 1
        end
      end
    end
    if @grid[y_coord][x_coord].opacity <= 4
      @grid[y_coord][x_coord].floor = 1
    end
  end

  def get_next_point(y_coord, x_coord)
    @stop = 0
    while true do
      direction = rand(0..3)
      case direction
        when 0
          if y_coord - 1 > 0
            if @grid[y_coord - 1][x_coord].floor != 1
              return [y_coord - 1, x_coord]
            else
              @stop += 1
            end
          else
            @stop += 1
          end
        when 1
          if x_coord + 1 < @width - 1
            if @grid[y_coord][x_coord + 1].floor != 1
              return [y_coord, x_coord + 1]
            else
              @stop += 1
            end
          else
            @stop += 1
          end
        when 2
          if y_coord + 1 < @height - 1
            if @grid[y_coord + 1][x_coord].floor != 1
              return [y_coord + 1, x_coord]
            else
              @stop += 1
            end
          else
            @stop += 1
          end
        when 3
          if x_coord - 1 > 0
            if @grid[y_coord][x_coord - 1].floor != 1
              return [y_coord, x_coord - 1]
            else
              @stop += 1
            end
          else
            @stop += 1
          end
        end
      end
  end

  def check_generation
    if @stop > 15
      return false
    else
      return true
    end
  end

end

@map = Map.new(8, 8)

#@map.show_map
@map.generate_map
@map.show_map

