# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


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

# класс карты, в котором и происходит всё веселье
class Map

  # изначально карта принимает два параментра для инициализации - высоты и ширину, образуя массив
  # каждый элемент массива - тайл. Счётчик остановки используется, чтобы не делать бесконечного цикла
  def initialize(height, width)
    @height = height
    @width = width
    @stop = 0

    rows, cols = @width, @height
    @grid = Array.new(rows) { Array.new(cols) {Tile.new} }
  end

  # показываем всю карту
  def show_map
    @grid.each do |y|
      y.each do |x|
        x.print_tile
      end
      print "\n"
    end
  end

  # метод содания карты. Берётся случайная первая точка, после чего выбирается направление и осуществляется проверка
  # на возможность проложить пол. Циклично, до тех пор, пока не накопится счётик остановки
  def generate_map
    @curr_point = get_start_point

    while check_generation do
      check_point_to_floor(@curr_point[0], @curr_point[1])
      @curr_point = get_next_point(@curr_point[0], @curr_point[1])
    end

  end

  # выбор первой случайной точки
  def get_start_point
    @rand_point = [rand(1..@height-2), rand(1..@width-2)]
  end

  # проверка точки - может ли она быть полом (считается по окружению)
  # вне зависимости от результата, после проверки точка будет считаться "использованной", т.е. на неё больше не пойдут
  def check_point_to_floor(y_coord, x_coord)
    @grid[y_coord][x_coord].touched = 1
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

  #TODO: модифицировать метод максимально уменьшив влияние вероятности и уменьшив "пустые итерации" к минимуму
  # алгоритм выбора следующей точки. Место наибольшей сложности
  def get_next_point(y_coord, x_coord)
    while @stop < 50 do
      direction = rand(0..3)
      case direction
        when 0
          if y_coord - 1 > 0
            if @grid[y_coord - 1][x_coord].touched != 1
              return [y_coord - 1, x_coord]
            else
              @stop += 1
            end
          else
            @stop += 1
          end
        when 1
          if x_coord + 1 < @width - 1
            if @grid[y_coord][x_coord + 1].touched != 1
              return [y_coord, x_coord + 1]
            else
              @stop += 1
            end
          else
            @stop += 1
          end
        when 2
          if y_coord + 1 < @height - 1
            if @grid[y_coord + 1][x_coord].touched != 1
              return [y_coord + 1, x_coord]
            else
              @stop += 1
            end
          else
            @stop += 1
          end
        when 3
          if x_coord - 1 > 0
            if @grid[y_coord][x_coord - 1].touched != 1
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

  # метод проверки генерации. Завершает её, если число остановки (количества ошибок) стало слишком большим.
  def check_generation
    if @stop < 50
      return true
    else
      return false
    end
  end

end

# создание и генерация карты
@map = Map.new(12, 12)

@map.generate_map
@map.show_map

