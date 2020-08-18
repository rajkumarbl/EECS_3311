note
	description: "JUMP user input"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_JUMP
inherit
	ETF_JUMP_INTERFACE
		redefine jump end
create
	make
feature -- command
	jump
		local
			jump_op: JUMP
			explain: BOOLEAN
    	do
			-- perform some update on the model state
			game.default_update
			create jump_op.make
			game.history.extend_history (jump_op)
			jump_op.execute
			explain := comment("dynamic binding: jump_op.execute")
			etf_cmd_container.on_change.notify ([Current])
    	end

end
