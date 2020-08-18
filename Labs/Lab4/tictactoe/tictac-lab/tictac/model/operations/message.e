note
	description: "Summary description for {MESSAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MESSAGE
inherit
	OPERATION
create
	make

feature {NONE}
	make(a_message: STRING)
		do
			stored_message := ""
			stored_instruction := ""

			old_message := game.message
			old_instruction := game.instruction

			stored_message := a_message
			stored_instruction := game.instruction
		end

feature {NONE} -- attr
old_message: STRING
old_instruction: STRING

feature -- commands
	execute
		require else
			message_not_void: stored_message /~ void
			instruction_not_void: stored_instruction /~ void
		do
			game.set_message (stored_message)
			game.set_instruction (stored_instruction)
		ensure then
			message_changed: game.message ~ stored_message
			instruction_changed: game.instruction ~ stored_instruction
		end

	undo
		do
			if not game.in_game then
				game.set_message ("ok:  => ")
			 	stored_message := "ok:  => "
			else
				game.set_message (old_message)
				game.set_instruction (old_instruction)
			end
		ensure then
			message_changed_back: game.message ~ old_message or game.message ~ "ok:  => "
			instruction_changed_back: game.instruction ~ old_instruction
		end

	redo
		do
			execute
		end
end
