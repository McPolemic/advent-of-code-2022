MOVES = %w[A B C]

def win?(my_move, their_move)
  my_move == MOVES[MOVES.index(their_move) - 2]
end

def score(round)
  their_move, my_move = round.tr("XYZ", "ABC").split(" ")
  score = MOVES.index(my_move) + 1

  if win?(my_move, their_move)
    score += 6
  elsif my_move == their_move
    score += 3
  end

  score
end

star_1 = File.read("day2.txt")
           .lines(chomp: true)
           .map{ score(_1) }
           .sum

puts "Star 1: #{star_1}"
