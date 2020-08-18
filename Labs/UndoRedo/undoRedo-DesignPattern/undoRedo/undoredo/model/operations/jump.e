note
	description: "Summary description for {JUMP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JUMP

inherit

	OPERATION
		redefine
			out
		end

	DEBUG_OUTPUT
		redefine
			out
		end

create
	make

feature {NONE}

	make
		do
			item := ""
			new_position := [0, 0]
			old_position := state.position

--			create random_sequence.make
		end

feature -- queries

	old_position: TUPLE [h: INTEGER; w: INTEGER]

	new_position: TUPLE [h: INTEGER; w: INTEGER]

	random: RANDOM_INTERVAL
		once
			create Result.make (1, state.grid2d.count)
		end

	convert_index_to_position (a_index: INTEGER): TUPLE [h: INTEGER; w: INTEGER]
		require
			state.grid2d.valid_index (a_index)
		local
			lh, lw: INTEGER
			rem: INTEGER
		do
			lh := (a_index // state.grid2d.width)
			rem := a_index \\ state.grid2d.width
			if rem = 0 then
				lh := lh
				lw := state.grid2d.width
			else
				lh := lh + 1
				lw := rem
			end
			Result := [lh, lw]
		end

feature

	index: INTEGER

	execute
		local
		do
			random.generate
			index := random.item
--			index := new_random
			check
				state.grid2d.valid_index (index)
			end
			item := "jump " + index.out
			new_position := convert_index_to_position (index)
			state.move (new_position.h, new_position.w)
			game.set_message ("ok, " + item)
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

--	new_random: INTEGER
--			-- Random integer
--			-- Each call returns another random number.
--		do
--			random_sequence.forth
--			Result := random_sequence.item
--			Result := Result \\ state.grid2d.count + 1
--		end

--feature {NONE} -- Implementation

--	random_sequence: RANDOM
--			-- Random sequence

end
