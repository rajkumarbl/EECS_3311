note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_RESTART
inherit 
	ETF_RESTART_INTERFACE
		redefine restart end
create
	make
feature -- command 
	restart
    	do
			-- perform some update on the model state
			game.default_update
			etf_cmd_container.on_change.notify ([Current])
    	end

end
