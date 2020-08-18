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
create
	make

feature{NONE} -- constructor
	make
			-- create a board with movable piece
			-- at position [1,1]
		do
			create grid2d.make_filled (empty, height, width)
			position := [1, 1]
			grid2d[1,1] := 1
		end

feature -- queries

	empty: INTEGER = 0

	height: INTEGER = 5
		-- height of the board
		-- number of rows

	width: INTEGER = 5
		-- width of the board
		-- number of columns

	grid2d: ARRAY2[INTEGER]
		-- the board whic is all zeros
		-- except the position
		-- of the piece which is 1

	position: TUPLE[h: INTEGER; w: INTEGER]
		-- position of a single piece on the board


feature -- commands

	move(a_height, a_width: INTEGER)
			-- move the piece to position [a_height, a_width]
		require
			valid_row: 1 <= a_height and a_height <= grid2d.height
			valid_column: 1 <= a_width and a_width <= grid2d.width
		do
			grid2d[position.h, position.w] := 0
			grid2d[a_height,a_width] := 1
			position := [a_height,a_width]
		ensure
			position ~ [a_height,a_width]
			grid2d[a_height,a_width] = 1
			grid2d[(old position.h), (old position.w)] = 0
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
					Result := Result + grid2d[h.item,w.item].out
				end
				Result := Result + "%N  "
			end
			Result := Result.substring (1, Result.count-3)
		end

invariant
	is_digit:
		across grid2d as cr all
			cr.item = 0 or cr.item = 1
		end
end

