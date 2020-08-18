note
	description: ""
	author: ""
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
			model.default_update
			if model.history.not_last then
				model.history.forth
				model.history.item.redo
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
