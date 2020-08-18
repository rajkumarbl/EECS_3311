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
	make(a_command_name, a_message: STRING)
		do
			item := a_command_name
			old_message := game.message
			new_message := a_message
		end

feature
	new_message: STRING

	old_message: STRING

	execute
		do
			game.set_message (new_message)
		end

	undo
		do
			game.set_message (old_message)
		end

	redo
		do
			execute
		end
end
