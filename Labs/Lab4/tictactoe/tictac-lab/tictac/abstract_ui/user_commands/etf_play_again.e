note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY_AGAIN
inherit
	ETF_PLAY_AGAIN_INTERFACE
		redefine play_again end
create
	make
feature -- command
	play_again
	    local
	    	play_again_op: PLAY_AGAIN
	    	message_op: MESSAGE
    	do
    		if not model.in_game then
    			create message_op.make (model.message)
    			model.history.extend_history (message_op)
    			message_op.execute

    		elseif not model.is_winner and not model.state.no_space_left then
    			create message_op.make (model.err_game_not_finished)
    			model.history.extend_history (message_op)
    			message_op.execute
    		else
				-- perform some update on the model state
				model.default_update
				model.set_is_winner (False)
				model.state.clear_board
				create play_again_op.make

				play_again_op.execute
				model.history.remove

			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
