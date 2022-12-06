def find_start_of_packet_marker(signal, packet_length = 4)
  signal
    .chars
    .each_cons(packet_length)
    .with_index
    .select{ _1.first.uniq == _1.first }
    .map{ [_1.first.join, _1.last + 4] }
    .first
end

input = File.read('day6.txt')
  .lines(chomp: true)
  .first

star_1 = find_start_of_packet_marker(input)
star_2 = nil

puts "Star 1: #{star_1}"
puts "Star 2: #{star_2}"
