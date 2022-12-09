class World
  def initialize(map)
    @map = map
  end

  def length = @map.first.count
  def height = @map.count
  def all_coords
    length.times.flat_map do |x|
      height.times.map do |y|
        [x, y]
      end
    end
  end

  def all_visible_coords = all_coords.select { |x, y| visible_from_an_edge?(x, y) }

  def visible_from_an_edge?(x, y)
    target_height = height_for(x, y)

    heights_above(x, y).all? { _1 < target_height } ||
    heights_below(x, y).all? { _1 < target_height } ||
    heights_left(x, y).all?  { _1 < target_height } ||
    heights_right(x, y).all? { _1 < target_height }
  end

  def height_for(x, y)
    @map[y][x]
  end

  def heights_above(x, y)
    return [] if y == 0
    (0...y).map { height_for(x, _1) }
  end

  def heights_below(x, y)
    return [] if y == height + 1
    (y+1...height).map { height_for(x, _1) }
  end

  def heights_left(x, y)
    return [] if x == 0
    (0...x).map { height_for(_1, y) }
  end

  def heights_right(x, y)
    return [] if x == length - 1
    (x+1...height).map { height_for(_1, y) }
  end

  def scenic_score(x, y)
    puts "trees_visible_above: #{trees_visible_above(x, y)}"
    puts "trees_visible_below: #{trees_visible_below(x, y)}"
    puts "trees_visible_left: #{trees_visible_left(x, y)}"
    puts "trees_visible_right: #{trees_visible_right(x, y)}"

    trees_visible_above(x, y) *
    trees_visible_below(x, y) *
    trees_visible_left(x, y)  *
    trees_visible_right(x, y)
  end

  def trees_visible_above(x, y)
    return 1 if y == 0

    target_height = height_for(x, y)
    (y-1).downto(0)
      .take_while { height_for(x, _1) < target_height }
      .count + 1
  end

  def trees_visible_below(x, y)
    return 1 if y == height - 1

    target_height = height_for(x, y)
    (y+1...height)
      .take_while { height_for(x, _1) < target_height }
      .count + 1
  end

  def trees_visible_left(x, y)
    return 1 if x == 0

    target_height = height_for(x, y)
    (x-1).downto(0)
      .take_while { height_for(_1, y) < target_height }
      .count + 1
  end

  def trees_visible_right(x, y)
    return 1 if x == length - 1

    target_height = height_for(x, y)
    (x+1...length)
      .take_while { height_for(_1, y) < target_height }
      .count + 1
  end
end

if __FILE__ == $0
  input = File.read('day8.txt')
    .lines(chomp: true)
    .map { _1.chars.map(&:to_i) }

  world = World.new(input)

  star_1 = world.all_visible_coords.count
  star_2 = nil

  puts "Star 1: #{star_1}"
  puts "Star 2: #{star_2}"
end
