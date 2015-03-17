require 'cave_gen/version'
require 'cave_gen/map'

module CaveGen
  class Cave
    def initialize(height = 20, width = 20, error = 100, opacity = 7)
      @map = Map.new(height, width, error, opacity)
      @map.generate_map

      @map
    end

    def show_map
      @map.show_map
    end

    def get_string
      @map.to_s
    end

    def to_symbol_array
      @map.to_symbol_array
    end

  end
end
