note
	description: "Summary description for {PLAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAY
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
			create stored_message.make_empty
			stored_instruction := ""
			create beginning_turn.make_empty
			old_message := game.message
			new_position := [1,1]
			symbol := "X"
		end

feature {NONE}-- attr
symbol: STRING
beginning_turn: STRING
new_position: TUPLE[h: INTEGER; w: INTEGER]
old_message: STRING


feature{ETF_PLAY,ES_TEST} --command

	set(player: STRING ;a_pos: INTEGER_64)
	require
		players_name_exist: game.p1.get_name ~ player or game.p2.get_name ~ player
		players_name_start: player.at (1).is_alpha
	    valid_button: a_pos >= 1 and a_pos <= 9
	    players_turn: ( game.p1.get_name ~ player and game.p1.get_turn ) or ( game.p2.get_name ~ player and game.p2.get_turn )
        there_is_empty_spot: not game.state.no_space_left
        state_spot_empty : game.state.grid2d.item (game.state.get_button_position(a_pos).h,game.state.get_button_position(a_pos).w) ~ "_"
	do
		if game.p1.turn then
			symbol := "X"
		else
			symbol := "O"
		end
		new_position := game.state.get_button_position(a_pos)
	ensure
		height_in_board: new_position.h >= 1 and new_position.h <= 3
		width_in_board : new_position.w >= 1 and new_position.w <= 3
		symbol_set: symbol ~ "X" or symbol ~ "O"
	end

	execute
		do
			game.state.insert (new_position.h, new_position.w, symbol)

			game.check_winner -- checking if there is a winner at this stage of the game
			if game.is_winner then
				stored_message := game.err_winner
				stored_instruction := "play again or start new game"
				game.history.remove
				if game.p1.get_turn then
					game.p1.set_score (game.p1.score + 1)
				else
					game.p2.set_score (game.p2.score + 1)
				end

			elseif game.state.no_space_left and not game.is_winner then --checking if there is tie at this stage of the game
				stored_message := game.err_game_tie
				stored_instruction := "play again or start new game"
				game.history.remove

			elseif game.p1.turn then
				beginning_turn := "p1"
				stored_message := game.err_success
				stored_instruction := game.p2.name + " plays next"
			else
				beginning_turn := "p2"
				stored_message := game.err_success
				stored_instruction := game.p1.name + " plays next"
			end

			if game.p1.get_turn then	-- setting the turns appropriately
				game.p1.set_turn (False)
				game.p2.set_turn (True)
			else
				game.p2.set_turn (False)
				game.p1.set_turn (True)
			end

	        if game.is_winner then		-- setting the message and instruction appropriately
				game.set_message (stored_message)
				game.set_instruction (stored_instruction)
				game.history.remove
			else
				game.set_message (stored_message)
				game.set_instruction (stored_instruction)
			end
		ensure then
			symbol_inserted: game.state.grid2d.item (new_position.h, new_position.w) /~ "_"
			proper_symbol_set: game.state.grid2d.item (new_position.h, new_position.w) ~ symbol
			turns_not_same: game.p1.get_turn /~ game.p2.get_turn
			turns_changed: game.p1.get_turn /~ old game.p1.get_turn and game.p2.get_turn /~ old game.p2.get_turn

	end

	undo
	do
		game.check_winner
		if game.is_winner then
			game.history.remove
			stored_instruction := "play again or start new game"
			stored_message := game.err_winner
			game.history.extend_history (current)
			game.set_instruction (stored_instruction)
			game.set_message (stored_message)
		elseif not game.is_winner and not game.state.no_space_left then
			if beginning_turn ~ "p1" then
				game.p1.set_turn (True)
				game.p2.set_turn (False)
				stored_instruction := game.p1.name + " plays next"
			else
				game.p1.set_turn (False)
				game.p2.set_turn (True)
				stored_instruction := game.p2.name + " plays next"
			end
			game.state.insert (new_position.h, new_position.w, "_")
			game.set_instruction (stored_instruction)
			game.set_message (old_message)
		else
			game.set_message (game.err_game_finished)
		end
	ensure then
		turns_not_same: game.p1.get_turn /~ game.p2.get_turn
	end

	redo
	do
		game.check_winner
		if game.is_winner then

		else
			execute
		end
	end

feature

	out: STRING
		do
			Result := stored_message
		end

	debug_output: STRING
		do
			Result := out
		end
invariant
   	    turns_diff : game.p1.get_turn /~ game.p2.get_turn
   	    height_in_board: new_position.h >= 1 and new_position.h <= 3
		width_in_board : new_position.w >= 1 and new_position.w <= 3
end

