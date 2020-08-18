note
	description: "handel MOVE user input"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MOVE
inherit
	ETF_MOVE_INTERFACE
		redefine move end
create
	make
feature -- command
	move(a_direction: INTEGER_64)
		require else
			move_precond(a_direction)
		local
			move_op: MOVE
			message_op: MESSAGE
			l_direction: STRING
			explain: BOOLEAN
    	do
			-- perform some update on the model state
			game.default_update
			create move_op.make
			if move_op.can_move (a_direction) then
				move_op.set(a_direction)
				game.history.extend_history (move_op)
				move_op.execute
				explain := comment("dynamic binding: move_op.execute")
			else
				l_direction := move_op.direction (a_direction)
				create message_op.make ("move("+l_direction+")", "cannot move there")
				game.history.extend_history (message_op)
				message_op.execute
			end



			etf_cmd_container.on_change.notify ([Current])
    	end

end
