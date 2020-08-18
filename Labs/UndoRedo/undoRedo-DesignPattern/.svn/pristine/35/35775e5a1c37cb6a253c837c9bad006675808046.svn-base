note
	description: "Handle redo user input"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_UNDO
inherit
	ETF_UNDO_INTERFACE
		redefine undo end
create
	make

feature -- command
	undo
		local
			explain: BOOLEAN
    	do
			-- perform some update on the model state
			game.default_update
			if game.history.on_item then
				game.history.item.undo
				explain := comment("dynamic binding: item.undo")
				game.set_message (game.history.item.item)
				game.history.back
			else
				game.set_message ("no more to undo")
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
