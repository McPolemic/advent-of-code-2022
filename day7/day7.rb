class LogReader
  TOTAL_SPACE = 70_000_000
  NEEDED_SPACE = 30_000_000

  attr_reader :contents, :line, :file_system

  def initialize(contents)
    @contents = contents
    @line = 0
    @file_system = {}
    @current_dir = ""
  end

  def current_line = @contents[@line]
  def base_command = current_line.split(' ')[1]
  def end_of_commands? = @line == @contents.length

  def directory_sizes
    directory_sizes = Hash.new(0)

    @file_system.each do |path, size|
      path.count("/").times do |i|
        directory_sizes[File.dirname(path, i+1)] += size
      end
    end

    directory_sizes
  end

  def directories_up_to_100_000
    directory_sizes.select{ |path, size| size <= 100_000 }.map(&:last).sum
  end

  def directory_to_delete
    available_space = TOTAL_SPACE - directory_sizes["/"]
    needed_space = NEEDED_SPACE - available_space

    # Loop through the directory sizes, finding something that's as small as
    # possible while still being over the needed space
    directory_sizes
      .select{ |path, size| size >= needed_space }
      .sort_by{ _1.last }
      .first
  end

  def read_commands!
    until end_of_commands?
      read_command!
    end
  end

  def read_command!
    case base_command
    when 'cd'
      directory = current_line.split(' ')[2]

      if directory == "/"
        @current_dir = "/"
      elsif directory == ".."
        # Remove the last entry from the current_dir
        @current_dir = @current_dir[0...@current_dir.rindex("/")]
      else
        @current_dir = File.join(@current_dir, directory)
      end
      @line += 1
    when 'ls'
      @line += 1
      until end_of_commands? || current_line.start_with?('$')
        # Skip all dir entries
        unless current_line.start_with? 'dir'
          size, filename = current_line.split(" ")
          @file_system[File.join(@current_dir, filename)] = size.to_i
        end
        @line += 1
      end
    end
  end
end

input = File.read('day7.txt')
  .lines(chomp: true)

log_reader = LogReader.new(input)
log_reader.read_commands!

star_1 = log_reader.directories_up_to_100_000
star_2 = log_reader.directory_to_delete.last

puts "Star 1: #{star_1}"
puts "Star 2: #{star_2}"
