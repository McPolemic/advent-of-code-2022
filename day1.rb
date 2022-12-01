input = File.read('day1.txt')
  .split("\n\n")
  .map do |series|
    series.lines.map{ _1.chomp.to_i }.sum
  end
  .sort

puts "Star 1: #{input.last}"
puts "Star 2: #{input[-3..-1].sum}"

