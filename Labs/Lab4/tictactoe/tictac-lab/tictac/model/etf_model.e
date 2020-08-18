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
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
			create s.make_empty
			i := 0
			create state.make
			create history.make
			message := "ok:  => "
			instruction := "start new game"
			create p1.make
			create p2.make
			p1.set_symbol ("X")
			p2.set_symbol ("O")
			p1.set_turn (True)
			p2.set_turn (False)
			is_winner := False
			in_game := false

		end

feature -- messages
	message: STRING
	instruction: STRING


	err_success : STRING
     attribute Result := "ok: => " end

    err_name_same : STRING
     attribute Result := "names of players must be different: => " end

    err_name_start : STRING
     attribute Result := "name must start with A-Z or a-z: => " end

    err_turn : STRING
     attribute Result := "not this player's turn: => " end

    err_name_no_match : STRING
     attribute Result := "no such player: => " end

    err_button : STRING
     attribute Result := "button already taken: => " end

    err_winner : STRING
     attribute Result := "there is a winner: => " end

    err_game_not_finished : STRING
     attribute Result := "finish this game first: => " end

    err_game_finished : STRING
     attribute Result := "game is finished: => " end

    err_game_tie : STRING
     attribute Result := "game ended in a tie: => " end

	set_message(a_message:STRING)
		do
			message := a_message
		end

	set_instruction(a_instruction:STRING)
		do
			instruction := a_instruction
		end

	set_is_winner (a_win: BOOLEAN)
	do
		is_winner := a_win
	end

	set_in_game (a_game: BOOLEAN)
	do
		in_game := a_game
	end

feature -- model attributes
	s : STRING
	i : INTEGER
	p1: PLAYER
	p2: PLAYER
	is_winner: BOOLEAN
	in_game: BOOLEAN

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

	check_winner
	do
		if state.grid2d.item (1,1) ~ state.grid2d.item (1,2) and state.grid2d.item (1,2) ~ state.grid2d.item (1,3) and state.grid2d.item (1,1) /~ "_" then
			is_winner := True

		elseif state.grid2d.item (2,1) ~ state.grid2d.item (2,2) and state.grid2d.item (2,2) ~ state.grid2d.item (1,3) and state.grid2d.item (2,1) /~ "_" then
			is_winner := True

		elseif state.grid2d.item (3,1) ~ state.grid2d.item (3,2) and state.grid2d.item (3,2) ~ state.grid2d.item (3,3) and state.grid2d.item (3,1) /~ "_" then
			is_winner := True

		elseif state.grid2d.item (1,1) ~ state.grid2d.item (2,1) and state.grid2d.item (2,1) ~ state.grid2d.item (3,1) and state.grid2d.item (1,1) /~ "_" then
			is_winner := True

		elseif state.grid2d.item (1,2) ~ state.grid2d.item (2,2) and state.grid2d.item (2,2) ~ state.grid2d.item (3,2) and state.grid2d.item (1,2) /~ "_" then
			is_winner := True

		elseif state.grid2d.item (1,3) ~ state.grid2d.item (2,3) and state.grid2d.item (2,3) ~ state.grid2d.item (3,3) and state.grid2d.item (1,3) /~ "_" then
			is_winner := True

		elseif state.grid2d.item (1,1) ~ state.grid2d.item (2,2) and state.grid2d.item (2,2) ~ state.grid2d.item (3,3) and state.grid2d.item (1,1) /~ "_" then
			is_winner := True

		elseif state.grid2d.item (1,3) ~ state.grid2d.item (2,2) and state.grid2d.item (2,2) ~ state.grid2d.item (3,1) and state.grid2d.item (1,3) /~ "_" then
			is_winner := True
		end
	end


	check_in_game
	do
		if(state.no_space_left) then
			in_game := false
		else
			in_game := true
		end
	end


feature -- queries

	out : STRING
			-- relected to the user
		do
			create Result.make_from_string ("  ")
			Result.append (message)
			Result.append (instruction)
			Result.append ("%N" + state.out)
			Result.append ("%N" + "  " + p1.get_score.out + ": score for " + "%"" + p1.get_name + "%"" + " (as " + p1.get_symbol + ")")
			Result.append ("%N" + "  " + p2.get_score.out + ": score for " + "%"" + p2.get_name + "%"" + " (as " + p2.get_symbol + ")")
		end

end



