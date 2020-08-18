note
	description: "[
		State of the game, which stores
			grid2d (i.e.. the board) of `height' by `width'
			position of a single piece on the board
			move operation
			]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	STATE
inherit
	ANY
		redefine out end
create{ETF_MODEL}
	make

feature{NONE} -- constructor
	make
			-- create a board with movable piece
			-- at position [1,1]
		do
			create grid2d.make_filled (empty, height, width)
			create empty_grid2d.make_filled (empty, height, width)
			position := [1, 1]
		end

feature -- queries

	empty: STRING = "_"

	height: INTEGER = 3
		-- height of the board
		-- number of rows

	width: INTEGER = 3
		-- width of the board
		-- number of columns

	grid2d: ARRAY2[STRING]
		-- the board whic is all "_"
		-- except the position
		-- of the piece which is 1

	position: TUPLE[h: INTEGER; w: INTEGER]
		-- position of a single piece on the board

	empty_grid2d: ARRAY2[STRING]

	get_button_position (a_pos: INTEGER_64) : TUPLE[h: INTEGER; w: INTEGER]
	require
	    valid_button: a_pos >= 1 and a_pos <= 9
	local
		new_position: TUPLE[h: INTEGER; w: INTEGER]
	do
		new_position := [1,1]
		if a_pos = 1 then
				new_position := [1,1]
			elseif a_pos = 2 then
				new_position := [1,2]
			elseif a_pos = 3 then
				new_position := [1,3]
			elseif a_pos = 4 then
				new_position := [2,1]
			elseif a_pos = 5 then
				new_position := [2,2]
			elseif a_pos = 6 then
				new_position := [2,3]
			elseif a_pos = 7 then
				new_position := [3,1]
			elseif a_pos = 8 then
				new_position := [3,2]
			else
				new_position := [3,3]
			end
		Result := new_position
	end

	no_space_left :BOOLEAN
	local
		no_slot : BOOLEAN
	do
		no_slot := True
		across 1 |..| height as h loop
				across 1 |..| width as w loop
				   if (grid2d[h.item, w.item] ~ "_") then
				   no_slot := false
				   end
			end
		end
		Result := no_slot
	end

feature -- commands

	insert(a_height, a_width: INTEGER; symbol: STRING)
	require
		valid_row: 1 <= a_height and a_height <= grid2d.height
		valid_column: 1 <= a_width and a_width <= grid2d.width
	do
		position := [a_height,a_width]
		grid2d[position.h, position.w] :=  symbol
	ensure
		position ~ [a_height,a_width]
    	grid2d[a_height,a_width] = symbol
	    grid2d[(old position.h), (old position.w)] ~ "_" or grid2d[(old position.h), (old position.w)] ~ "X" or grid2d[(old position.h), (old position.w)] ~ "O"
	end

	clear_board
	do
--		across 1 |..| height as h loop
--				across 1 |..| width as w loop
--					grid2d[h.item, w.item] := "_"
--			end
--		end
		grid2d.make_filled (empty, height, width)
	ensure
		board_cleared: grid2d.is_equal (empty_grid2d)
	end

feature  -- out
	out: STRING
			-- repersentation of board
			-- as zeros and ones
		local
			l_show: STRING
		do
			Result := "  "
			across 1 |..| height as h loop
				across 1 |..| width as w loop
					Result := Result + grid2d[h.item,w.item]
				end
				Result := Result + "%N  "
			end
			Result := Result.substring (1, Result.count-3)
		end

invariant
	is_symbol: across grid2d as cr all  cr.item ~ "_" or cr.item ~ "X" or cr.item ~ "O"	end
	height_in_board: position.h >= 1 and position.h <= 3
	width_in_board : position.w >= 1 and position.w <= 3
end

