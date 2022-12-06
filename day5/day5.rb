require 'forwardable'

class ConfigReader
  attr_reader :config

  def initialize(path)
    @config = File.read(path)
      .lines(chomp: true)
  end

  def config_separator_index = config.index("")

  def starting_config
    config[0...config_separator_index]
      # We want the stack numbers at the top to determine what's
      # a column and what's just syntax
      .reverse
      .map(&:chars)
      .transpose
      # Remove non-stack columns
      .reject { |line| line.first !~ /\d+/ }
      # Remove stack numbers and blank lines
      .map { |line| line[1..-1].reject { _1 == " " } }
  end

  # Converts a series of commands:
  # move 2 from 2 to 1
  # move 1 from 1 to 2
  #
  # into an array of integers for Workspace#move:
  # [2, 2, 1]
  # [1, 1, 2]
  def commands
    config[config_separator_index+1..-1]
      .map do |line|
        line.match(/move (\d+) from (\d+) to (\d+)/)
          .captures
          .map(&:to_i)
      end
  end
end

class Stack
  extend Forwardable

  def_delegators :@pile, :push, :pop

  def initialize(contents = [])
    @pile = contents
  end
end

class Workspace
  attr_reader :stacks
  # We'll add an empty Stack for the 0 index so we can use
  # 1-indexed `from` and `to` values
  def initialize(stacks)
    @stacks = [[]] + stacks
  end

  def move(quantity, from, to)
    quantity.times do
      @stacks[to].push(@stacks[from].pop)
    end
  end

  def top_of_stacks
    @stacks.map(&:last).join
  end
end

# New, improved!
class CrateMover9001 < Workspace
  def move(quantity, from, to)
    @stacks[to].push(*@stacks[from].pop(quantity))
  end
end

config = ConfigReader.new("day5.txt")
workspace = Workspace.new(config.starting_config)
crate_mover_9001 = CrateMover9001.new(config.starting_config)

# Run the commands
config
  .commands
  .each do |quantity, from, to|
    workspace.move(quantity, from, to)
    crate_mover_9001.move(quantity, from, to)
  end

pp crate_mover_9001
puts "Star 1: #{workspace.top_of_stacks}"
puts "Star 2: #{crate_mover_9001.top_of_stacks}"
