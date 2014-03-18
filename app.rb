require 'rubygems'
require 'pry'
require_relative 'src/robot'
require_relative 'src/board'

@board = Board.new
@error = nil
ERROR_STRINGS = File.read('error_strings.txt').split("\n")

def redraw
  system("clear") || system("cls")
  puts " #{' '*15} [P]LACE {x} {y}"
  puts "#{@board.draw 0}  [M]OVE"
  puts "#{@board.draw 1}  [L]EFT"
  puts "#{@board.draw 2}  [R]IGHT"
  puts "#{@board.draw 3}  R[E]PORT"
  puts "#{@board.draw 4}  [Q]UIT"
  puts "#{@error}"
  print '>> '
end

redraw

ARGF.each do |line|
  @error = nil
  case line.strip
  when /\s*(p|place)\s+(\d)\s+(\d)/i
    @robot = Robot.new Integer($2), Integer($3)
    @board.robot = @robot
  when /\s*(m|move)/i
    @robot ? @robot.move : (@error = ERROR_STRINGS[1])
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

