require_relative 'src/robot'
require_relative 'src/board'

@board = Board.new
@error = nil
ERROR_STRINGS = File.read('error_strings.txt').split("\n")

def redraw
  system("clear") || system("cls")
  puts " #{' ' * 15} [P]LACE {x} {y} |N/E/S/W|"
  puts "#{@board.draw 4}  [M]OVE"
  puts "#{@board.draw 3}  [L]EFT"
  puts "#{@board.draw 2}  [R]IGHT"
  puts "#{@board.draw 1}  R[E]PORT"
  puts "#{@board.draw 0}  [Q]UIT"
  puts "#{@error}"
  print '>> '
end

redraw

ARGF.each do |line|
  @error = nil
  case line.strip
  when /\s*(p|place)\s+(\d)\s+(\d)(\s+\w)?/i
    x, y = Integer($2), Integer($3)
    if !(x.between?(0,4) && y.between?(0,4))
      @error = ERROR_STRINGS[2]
    elsif @robot
      @robot.teleport x, y, $4
    else
      @robot = Robot.new x, y, $4
      @board.robot = @robot
      @robot.board = @board
    end
  when /\s*(m|move)/i
    @error = ERROR_STRINGS[1] unless @robot
    @error = ERROR_STRINGS[3] unless @robot && @robot.move
  when /\s*(l|left)/i
    @error = (@robot ? @robot.rotate(-1) : ERROR_STRINGS[1])
  when /\s*(r|right)/i
    @error = (@robot ? @robot.rotate : ERROR_STRINGS[1])
  when /\s*(e|report)/i
    @error = (@robot ? @robot.report : ERROR_STRINGS[1])
  when /\s*(q|quit)/i
    puts "\n   Quitting..."
    break
  else
    @error = ERROR_STRINGS[0]
  end
  redraw
end

