# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

require '../lib/map'

# создание и генерация карты
@map = Map.new(40, 60)

@map.generate_map
@map.show_map