puts "TIC-TAC-TOE"
#puts "How many players?"
num_players = 2
$player_icons = []
$board = [["", "", ""], ["", "", ""], ["", "", ""]]
$winner = ""

#takes a number of players and asks a user or users  to choose player icons.
#returns player icons as an array corresponding to player number minus one
def select_player_icon(num_players)
	icons = []
	while icons == []
		if num_players == 1
			puts "Player 1, choose X or O."
			icons.push(gets.chomp)
			if icons[0] != "X" && icons[0] != "O"
				icons.delete_at(0)
			else
				puts "Player's 1 icon is " + icons[0] + "."
			end
		elsif num_players == 2
			puts "Player 1, choose X or O."		
			icons.push(gets.chomp)
			if icons[0] == "X"
				icons.push("O")			
				puts "Player's 1 icon is " + icons[0] + "."
				puts "Player's 2 icon is " + icons[1] + "."
			elsif icons[0] == "O"
				icons.push("X")
				puts "Player's 1 icon is " + icons[0] + "."
				puts "Player's 2 icon is " + icons[1] + "."
			else
				icons.delete_at(0)
			end
		end	
	end
	return icons
end

#displays a board array as as a string
def print_board(board)
	board_as_string = ""
	for x in 0 ... board.size
		new_line = ""
		for y in 0 ... board[x].size
			if board[x][y] == ""
				new_line = new_line + "|" + " " + "|"
			else
				new_line = new_line + "|" + board[x][y] + "|"
			end
		end
		new_line = new_line[1..-2]
		new_line = new_line.gsub("||", "|")			
		board_as_string = board_as_string + new_line + "\n"
		if x < 2
			board_as_string = board_as_string + "-----\n"
		end
	end
	return board_as_string
end

def is_full?(board)
	for x in 0 ... board.size
		for y in 0 ... board[x].size
			if board[x][y] == ""
				return false
			end
		end
	end
	return true
end

#takes in a board and returns X or O if a match is found.  Returns an empty string otherwise 
def check_game_status(board)

	winning_options = []

	for x in 0 ... board.size
		winning_options.push([board[0][x], board[1][x], board[2][x]])
	end

	for y in 0 ... board[0].size
		winning_options.push([board[y][0], board[y][1], board[y][2]])
	end
	
	winning_options.push([board[0][0], board[1][1], board[2][2]])
	winning_options.push([board[0][2], board[1][1], board[2][0]])

	winning_options.each do |i|
		if i[0] == i[1] && i[1] == i[2] && i[0] != ""
			return i[0]
		end
	end

	if is_full?(board)
		return "draw"
	end

	return ""
end

$player_icons = select_player_icon(num_players)

#takes in a board, an icon, and a set of coordinates and returns a board with icon placed at the coordinates
def place_icon(board, icon, coordinates)
	board[coordinates[0]][coordinates[1]] = icon
	return board
end

#takes in a board and coordinate(x and y) and returns true if cell is empty
def is_empty?(board, x, y)
	if board[x][y] == ""
		return true
	else
		return false
	end
end

#main game loop
while $winner == ""
	for x in 0 ... $player_icons.size
		puts "Player " + (x + 1).to_s  + "'s turn"
		puts print_board($board)
		row = 0
		column = 0
		loop do
			puts "Enter row (1 - 3):"
			row = gets.chomp.to_i
			while row < 1 || row > 3
				puts "Please enter a number between 1 and 3:"
				row = gets.chomp.to_i
			end
			puts "Enter column (1 - 3): "
			column = gets.chomp.to_i
			while column < 1 || column > 3
				puts "Please enter a number between 1 and 3:"
				column = gets.chomp.to_i
			end
			break if is_empty?($board, row - 1, column - 1)
			puts "Please choose an empty square."
		end
		$board = place_icon($board, $player_icons[x], [row.to_i - 1, column.to_i - 1])
		status = check_game_status($board)
		if status != ""
			winner_index = $player_icons.index(status)
			if winner_index != nil
				$winner = "Player " + (winner_index + 1).to_s
			else
				$winner = "draw"
			end
			puts print_board($board)	
			break
		end
	end	
end

if $winner == "draw"
	puts "Draw!"
else
	puts $winner + " wins!"
end
