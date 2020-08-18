note
	description: "Summary description for {PLAY_AGAIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAY_AGAIN

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
			create beginning_turn.make_empty
			stored_instruction := ""
			game.state.clear_board
		end

feature {NONE} -- attr
beginning_turn: STRING


feature{ETF_PLAY_AGAIN,ES_TEST} --command

	execute
		do
			if game.p1.went_first then
				beginning_turn := "p2"
				game.p2.set_went_first (True)
				game.p1.set_went_first (False)
				game.p1.set_turn (False)
				game.p2.set_turn (True)
				stored_message := "ok: => "
				stored_instruction := game.p2.name + " plays next"
			else
				beginning_turn := "p1"
				game.p2.set_went_first (False)
				game.p1.set_went_first (True)
				game.p2.set_turn (False)
				game.p1.set_turn (True)
				stored_message := "ok: => "
				stored_instruction := game.p1.name + " plays next"
			end

			game.history.remove

			game.set_message (stored_message)
			game.set_instruction (stored_instruction)
		ensure then
			message_changed: game.message ~ stored_message
			instruction_changed: game.instruction ~ stored_instruction
			turns_not_same: game.p1.get_turn /~ game.p2.get_turn
			went_first_not_same: game.p1.get_went_first /~ game.p2.get_went_first
			history_reset: game.history.get_count ~ "0"
	end

	undo
		do
			game.set_message ("ok: => ")
			if game.p1.turn then
				game.set_instruction (game.p1.name + " plays next")
			else
				game.set_instruction (game.p2.name + " plays next")
			end
		ensure then
			message_set: game.message ~ "ok: => "
			instruction_set: game.instruction ~ game.p1.name + " plays next" or game.instruction ~ game.p2.name + " plays next"
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


