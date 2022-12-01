input = File.read('day1.txt')
  .lines(chomp: true)
  .slice_when { |_, after| after.empty? }
  .map { |elf_cals| elf_cals.map(&:to_i).sum }
  .sort

puts "Star 1: #{input.last}"
puts "Star 2: #{input[-3..-1].sum}"
