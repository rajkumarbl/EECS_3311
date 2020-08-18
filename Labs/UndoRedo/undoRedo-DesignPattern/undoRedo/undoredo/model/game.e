note
	description: "[
		A 2-dimensional board with a single movable piece
		that can move left, right, up and down
		as well as take a random jump.
		Supported by an und/redeo design pattern
		as in OOSC2 Chapter 21
		]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	GAME

inherit
	ANY
		redefine
			out
		end

create {GAME_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create s.make_empty
			i := 0
			create state.make
			create history.make
			message := "ok"
		end

feature -- messages
	message: STRING

	set_message(a_message:STRING)
		do
			message := a_message
		end

feature -- model attributes
	s : STRING
	i : INTEGER

	state: STATE
	history: HISTORY

feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			i := i + 1
		end

	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
			-- relected to the user
		do
			create Result.make_from_string ("  ")
			Result.append ("state ")
			Result.append (i.out)
			Result.append (": ")
			Result.append (message)
			Result.append ("%N" + state.out)
		end

end




