note
	description: "Summary description for {NEW_GAME}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEW_GAME

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
	    local
	    	ma: ETF_MODEL_ACCESS
		do

			create p1name.make_empty
			create p2name.make_empty
			stored_message := ""
			stored_instruction := ""
			game.state.clear_board
		end

feature{NONE} -- attr
	p1name: STRING
	p2name: STRING

feature {ETF_NEW_GAME,ES_TEST} --command

	new_game(a_name1: STRING; a_name2: STRING)
		require
			players_name_different: a_name1 /~ a_name2
			players_name_start: a_name1.at (1).is_alpha and a_name2.at (1).is_alpha
		do
			game.p1.set_name (a_name1)
			game.p2.set_name (a_name2)
		ensure
			player1_name_set: game.p1.get_name ~ a_name1
			player2_name_set: game.p2.get_name ~ a_name2
	end

	set_players(a_name1: STRING; a_name2: STRING)
		require
			players_name_different: a_name1 /~ a_name2
			players_name_start: a_name1.at (1).is_alpha and a_name2.at (1).is_alpha
		do
			p1name := a_name1
			p2name := a_name2
		ensure
			player1_name_set: p1name ~ a_name1
			player2_name_set: p2name ~ a_name2
		end

	execute
		do
			game.p1.set_went_first(True)
			game.p2.set_went_first(False)
			game.p1.set_turn(True)
			game.p2.set_turn(False)
			game.p1.set_score (0)
			game.p2.set_score (0)
			stored_message := ("ok: => ")
			new_game(p1name, p2name)
			stored_instruction := (p1name + " plays next")

			game.set_message (stored_message)
			game.set_instruction (stored_instruction)
		ensure then
			turns_not_same: game.p1.get_turn /~ game.p2.get_turn
			went_first_not_same: game.p1.get_went_first /~ game.p2.get_went_first
			scores_reset: game.p1.get_score = 0 and game.p2.get_score = 0
			message_changed: game.message ~ stored_message
			instruction_changed: game.instruction ~ stored_instruction
		end

	undo
		do
			game.set_message (stored_message)
			game.set_instruction (stored_instruction)
		ensure then
			message_changed: game.message ~ stored_message
			instruction_changed: game.instruction ~ stored_instruction
		end

	redo
		do
			execute
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

end
