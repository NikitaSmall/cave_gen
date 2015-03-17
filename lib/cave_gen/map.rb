require_relative 'tile'

# класс карты, в котором и происходит всё веселье
class Map

  # изначально карта принимает два параментра для инициализации - высоты и ширину, образуя массив
  # каждый элемент массива - тайл. Счётчик остановки используется, чтобы не делать бесконечного цикла
  def initialize(height = 20, width = 20, error = 100, opacity = 7)
    @height = height
    @width = width
    @stop = 0
    @error = error
    @opacity_challenge = opacity

    rows, cols = @width, @height

    @grid = Array.new(cols)
    cols.times do |y|
      @grid[y] = Array.new(rows)
      rows.times do |x|
        @grid[y][x] = Wall.new(y, x)
      end
    end
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

    @curr_point = get_rand_point
    while end_generation? do
      check_point_to_floor(@curr_point[0], @curr_point[1])
      @curr_point = get_next_point(@curr_point[0], @curr_point[1])
    end
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
        if @grid[y][x].is_floor?
          @grid[y_coord][x_coord].opacity += 1
        end
      end
    end
    if @grid[y_coord][x_coord].opacity < @opacity_challenge
      @grid[y_coord][x_coord] = Floor.new(y_coord, x_coord, @grid[y_coord][x_coord].opacity)
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

  def is_floor?(y_coord, x_coord)
    return @grid[y_coord][x_coord].is_floor?
  end

  def to_s
    string = ''
    @grid.each do |y|
      y.each do |x|
        string = string + x.get_tile
      end
      string = string + "\n"
    end
    return string
  end

  def to_symbol_array
    string = Array.new
    @grid.each_with_index do |y, y_index|
      y.each_with_index do |x, x_index|
        string[y_index][y_index] = x.get_tile
      end
    end
    return string
  end

end