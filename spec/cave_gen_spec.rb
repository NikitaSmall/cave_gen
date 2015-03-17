require 'rspec'
require 'cave_gen'

describe CaveGen::Cave do
  it 'should return dots and hashes' do
    cave = CaveGen::Cave.new()
    cave.get_string.should include(".", "#")
  end
end