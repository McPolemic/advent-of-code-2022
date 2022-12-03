MOVES = %w[A B C]

def draw!(their_move) = their_move
def win!(their_move)  = MOVES[MOVES.index(their_move) - 2]
def lose!(their_move) = MOVES[MOVES.index(their_move) - 1]

def find_move(round)
  their_move, game_outcome = round.split(" ")
  case game_outcome
  when "X"
    lose!(their_move)
  when "Y"
    draw!(their_move)
  when "Z"
    win!(their_move)
  end
end

def move_score(my_move) = MOVES.index(my_move) + 1

def score(round)
  their_move, game_outcome = round.split(" ")

  score = 0
  my_move = case game_outcome
            when "X"
              lose!(their_move)
            when "Y"
              score += 3
              draw!(their_move)
            when "Z"
              score += 6
              win!(their_move)
            end

  score + move_score(my_move)
end

star_2 = File.read("day2.txt")
           .lines(chomp: true)
           .map{ score(_1) }
           .sum

puts "Star 2: #{star_2}"
