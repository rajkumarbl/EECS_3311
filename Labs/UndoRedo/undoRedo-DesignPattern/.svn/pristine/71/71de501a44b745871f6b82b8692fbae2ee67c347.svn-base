note
	description: "Handle undo user input"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_REDO
inherit
	ETF_REDO_INTERFACE
		redefine redo end
create
	make
feature -- command
	redo
		local
			explain: BOOLEAN
    	do
			-- perform some update on the model state
			game.default_update
			if game.history.not_last then
				game.history.forth
				game.history.item.redo
				explain := comment("dynamic binding: item.redo")
				game.set_message (game.history.item.item)
			else
				game.set_message ("no more to redo")
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
