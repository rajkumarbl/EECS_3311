note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_NEW_GAME
inherit
	ETF_NEW_GAME_INTERFACE
		redefine new_game end
create
	make
feature -- command
	new_game(player1: STRING ; player2: STRING)
		require else
			new_game_precond(player1, player2)
		local
			new_game_op: NEW_GAME
			message_op: MESSAGE
    	do
    		if player1 ~ player2 and not model.in_game then
    			create message_op.make ("names of players must be different:  => ")
    			message_op.execute
    			model.history.extend_history (message_op)

			elseif (not player1.at(1).is_alpha or not player2.at(1).is_alpha) and not model.in_game then
				create message_op.make ("name must start with A-Z or a-z:  => ")
    			message_op.execute
                model.history.extend_history (message_op)

    		elseif player1 ~ player2 then
    			create message_op.make (model.err_name_same)
    			message_op.execute
    			model.history.extend_history (message_op)

    		elseif not player1.at(1).is_alpha or not player2.at (1).is_alpha then
    			create message_op.make (model.err_name_start)
    			message_op.execute
    			model.history.extend_history (message_op)

            else
			-- perform some update on the model state
			model.default_update
			model.set_is_winner (False)
			model.set_in_game (true)
			model.state.clear_board
			create new_game_op.make
			model.history.remove
			new_game_op.set_players (player1, player2)
			new_game_op.execute
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
