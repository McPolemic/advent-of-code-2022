# Divide contents in half and look for duplicates between the two halves
def find_common_items(rucksack)
  pocket_1, pocket_2 = rucksack
    .chars
    .each_slice(rucksack.length/2)
    .to_a

  pocket_1 & pocket_2
end

# Find the common item among three rucksacks
def find_shared_badge(three_rucksacks)
  items = three_rucksacks.map(&:chars)
  items.reduce(:&)
end

# For each item, find its priority
# 'a' .. 'z' = 1 .. 26
# 'A' .. 'Z' = 27 .. 52
# Then get the sum of all priorities
def priority(list_of_items)
  list_of_items.map do |item|
    case item
    when /[a-z]/
      item.ord - 'a'.ord + 1
    when /[A-Z]/
      item.ord - 'A'.ord + 27
    end
  end
  .sum
end


input = File.read('day3.txt')
  .lines(chomp: true)

star_1 = input
  .map { |rucksack| find_common_items(rucksack) }
  .map { |items| priority(items) }
  .sum

star_2 = input
  .each_slice(3)
  .flat_map { |three_rucksacks| find_shared_badge(three_rucksacks) }
  .then { |badges| priority(badges) }

puts "Star 1: #{star_1}"
puts "Star 2: #{star_2}"
