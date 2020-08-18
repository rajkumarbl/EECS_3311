note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PLAY
inherit
	ETF_PLAY_INTERFACE
		redefine play end
create
	make
feature -- command
	play(player: STRING ; press: INTEGER_64)
		require else
			play_precond(player, press)
		local
			play_op : PLAY
			message_op: MESSAGE
    	do
    		model.check_winner
    		if model.is_winner or (model.state.no_space_left and not model.is_winner) then
    			create message_op.make (model.err_game_finished)
    			model.history.extend_history (message_op)
    			message_op.execute
    			model.history.remove

    		elseif model.p1.get_name ~ player and not model.p1.get_turn then
    			create message_op.make (model.err_turn)
    			model.history.extend_history (message_op)
    			message_op.execute

    		elseif model.p2.get_name ~ player and not model.p2.get_turn then
    			create message_op.make (model.err_turn)
    			model.history.extend_history (message_op)
    			message_op.execute

    		elseif model.p1.get_name /~ player and model.p2.get_name /~ player and not model.in_game then
    			create message_op.make ("no such player:  => ")
    			model.history.extend_history (message_op)
    			message_op.execute

    		elseif model.p1.get_name /~ player and model.p2.get_name /~ player then
    			create message_op.make (model.err_name_no_match)
    			model.history.extend_history (message_op)
    			message_op.execute

    		elseif not player.at(1).is_alpha  then
    			create message_op.make (model.err_name_start)
    			model.history.extend_history (message_op)
    			message_op.execute

    		elseif model.state.grid2d.item (model.state.get_button_position(press).h,model.state.get_button_position(press).w) /~ "_"  then
    			create message_op.make (model.err_button)
    			model.history.extend_history (message_op)
    			message_op.execute

			elseif model.state.no_space_left and not model.is_winner then
				create message_op.make (model.err_game_tie)
    			model.history.extend_history (message_op)
    			message_op.execute

            else
			-- perform some update on the model state
			model.default_update
			create play_op.make
			play_op.set (player,press)
			model.history.extend_history (play_op)
			play_op.execute
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
