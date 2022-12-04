class Range
  # Creates a range from a dashed string (e.g. "2-4")
  def self.from_dash_range(dash_range)
    beginning, ending = dash_range.split("-").map(&:to_i)
    new(beginning, ending)
  end
end

class AssignmentPair
  attr_reader :first, :second

  def initialize(line)
    @first, @second = line
      .split(",")
      .map { Range.from_dash_range(_1) }
  end

  def completely_overlapping?
    first.cover?(second) || second.cover?(first)
  end

  def overlapping?
    first.begin <= second.end && first.end >= second.begin
  end
end

input = File.read('day4.txt')
  .lines(chomp: true)
  .map{ |assignment_row| AssignmentPair.new(assignment_row) }

star_1 = input
  .select(&:completely_overlapping?)
  .count

star_2 = input
  .select(&:overlapping?)
  .count

puts "Star 1: #{star_1}"
puts "Star 2: #{star_2}"
