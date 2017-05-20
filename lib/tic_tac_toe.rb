WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  row(board, 0, 1, 2)
  line
  row(board, 3, 4, 5)
  line
  row(board, 6, 7, 8)
end

def row(board, num1, num2, num3)
  puts " #{board[num1]} | #{board[num2]} | #{board[num3]} "
end

def line
  puts "-----------"
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, token)
  board[index] = token
end

def valid_move?(board, index)
  !position_taken?(board, index) && index.between?(0, 8)
end

def position_taken?(board, index)
  board[index] == "X" || board[index] == "O"
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  valid_move?(board, index) ? move(board, index, current_player(board)) : turn(board)
  display_board(board)
end

def turn_count(board)
  board.count{|x| x != " "}
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def won?(b)
  WIN_COMBINATIONS.find{|a| b[a[0]] == b[a[1]] && b[a[1]] == b[a[2]] && position_taken?(b, a[0])}
end

def winner(board)
  won?(board) ? board[won?(board)[0]] : nil
end

def full?(board)
  board.all?{|x| x != " "}
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def play(board)
  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cats Game!"
  end
end
