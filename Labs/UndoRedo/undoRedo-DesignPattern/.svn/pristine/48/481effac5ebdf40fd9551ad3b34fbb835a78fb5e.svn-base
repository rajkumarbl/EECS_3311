note
	description: "Move operation with undo/redo"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	MOVE
inherit
	OPERATION
		redefine out end
	DEBUG_OUTPUT
		redefine out end
create
	make

feature {NONE} -- constructor
	make
		do
			item := ""
			new_position := [0,0]
			old_position := state.position
		end
feature  -- queries
	old_position: TUPLE[h:INTEGER; w: INTEGER]
	new_position: TUPLE[h:INTEGER; w: INTEGER]

	left: INTEGER =1
	right: INTEGER =2
	up: INTEGER =3
	down: INTEGER =4

	can_move(a_direction: INTEGER_64): BOOLEAN
		require
			left <= a_direction
			a_direction <= down
		do
			inspect a_direction
			when 1 then -- left
				Result := old_position.w - 1 >= 1
			when 2 then -- right
				Result := old_position.w + 1 <= state.grid2d.width
			when 3 then -- up
				Result := old_position.h -1 >= 1
			else -- down
				Result := old_position.h+1 <= state.grid2d.height
			end
		end

	direction(a_direction:INTEGER_64): STRING
		require
			left <= a_direction
			a_direction <= down
		do
			inspect a_direction
			when 1 then
				Result := "left"
			when 2 then
				Result := "right"
			when 3 then
				Result := "up"
			else
				Result := "down"
			end
		end
feature -- commands
	set(a_direction: INTEGER_64)
		require
			left <= a_direction
			a_direction <= down
			can_move(a_direction)
		local
			l_direction: STRING
		do
			old_position := state.position
			inspect a_direction
			when 1 then
				l_direction := "left"
				new_position := [old_position.h, old_position.w - 1]
			when 2 then
				l_direction := "right"
				new_position := [old_position.h, old_position.w + 1]
			when 3 then
				l_direction := "up"
				new_position := [old_position.h -1, old_position.w]
			else
				l_direction := "down"
				new_position := [old_position.h+1, old_position.w]
			end
			item := "move"
				+ "("
				+ l_direction
				+ ")"
		end


	execute
		do
			state.move (new_position.h, new_position.w)
			game.set_message ("ok")
		end

	undo
		do
			state.move (old_position.h, old_position.w)
		end


	redo
		do
			execute
		end

feature
	out: STRING
		do
			Result := item
		end

	debug_output: STRING
		do
			Result := out
		end
end
