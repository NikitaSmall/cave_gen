require '../lib/tile'
require '../lib/creature'
require 'enumerator'

# класс карты, в котором и происходит всё веселье
class Map

  # изначально карта принимает два параментра для инициализации - высоты и ширину, образуя массив
  # каждый элемент массива - тайл. Счётчик остановки используется, чтобы не делать бесконечного цикла
  def initialize(height, width)
    @height = height
    @width = width
    @stop = 0
    @error = 100
    @opacity_challenge = 8

    rows, cols = @width, @height
    @grid = Array.new(cols) { Array.new(rows) {Tile.new} }
    @hero = nil
  end

  #TODO: модифицировать метод так, чтобы отображение многих монстров не превратилось в проблему
  # показываем всю карту
  def show_map
    @grid.each_with_index do |y, y_coord|
      y.each_with_index do |x, x_coord|
        if @hero.x_coord == x_coord && @hero.y_coord == y_coord
          print @hero.symbol
        else
          x.print_tile
        end
      end
      print "\n"
    end
  end

  # метод содания карты. Берётся случайная первая точка, после чего выбирается направление и осуществляется проверка
  # на возможность проложить пол. Циклично, до тех пор, пока не накопится счётик остановки
  def generate_map
    @curr_point = get_rand_point

    while end_generation? do
      check_point_to_floor(@curr_point[0], @curr_point[1])
      @curr_point = get_next_point(@curr_point[0], @curr_point[1])
    end

    get_hero
  end

  # выбор первой случайной точки
  def get_rand_point
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
    if @grid[y_coord][x_coord].opacity <= @opacity_challenge
      @grid[y_coord][x_coord].floor = 1
    end
  end

  # алгоритм выбора следующей точки. Место наибольшей сложности
  def get_next_point(y_coord, x_coord)
    while end_generation? do
      directions = Array.new
      if y_coord - 1 > 0
        if @grid[y_coord - 1][x_coord].touched != 1
          directions << 0
        end
      end
      if x_coord + 1 < @width - 1
        if @grid[y_coord][x_coord + 1].touched != 1
          directions << 1
        end
      end
      if y_coord + 1 < @height - 1
        if @grid[y_coord + 1][x_coord].touched != 1
          directions << 2
        end
      end
      if x_coord - 1 > 0
        if @grid[y_coord][x_coord - 1].touched != 1
          directions << 3
        end
      end

      unless directions.empty?
        direction = directions.sample
      else
        y_coord, x_coord = get_rand_point
        @stop += 10
        next
      end
      case direction
        when 0
          return [y_coord - 1, x_coord]
        when 1
          return [y_coord, x_coord + 1]
        when 2
          return [y_coord + 1, x_coord]
        when 3
          return [y_coord, x_coord - 1]
      end

    end
  end

  # метод проверки генерации. Завершает её, если число остановки (количества ошибок) стало слишком большим.
  def end_generation?
    if @stop < @error
      return true
    else
      return false
    end
  end

  def get_hero
    unless @hero
      y_coord, x_coord = get_rand_point
      loop do
        break if is_floor?(y_coord, x_coord)
        y_coord, x_coord = get_rand_point
      end
      @hero = Hero.new(y_coord, x_coord, "NikitaSmall")
      return @hero
    else
      return @hero
    end
  end

  #def add_objects_to_map
  #  @hero = Hero.new()
  #end

  def is_floor?(y_coord, x_coord)
    if @grid[y_coord][x_coord].floor == 1
      return true
    else
      return false
    end
  end

end