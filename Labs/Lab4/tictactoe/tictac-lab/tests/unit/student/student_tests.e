note
	description: "Summary description for {STUDENT_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS

inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization



	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent t01)
			add_boolean_case (agent t02)
			add_boolean_case (agent t03)
			add_boolean_case (agent t04)
			--violation cases
			add_violation_case (agent tf1)
			add_violation_case (agent tf2)
			add_violation_case (agent tf3)
			add_violation_case (agent tf4)
		end

feature -- tests

	    t01: BOOLEAN
		local
			new_game_op: NEW_GAME
		do
		    comment("t01: test the NEW_GAME module")
			create new_game_op.make
			new_game_op.set_players ("Phil", "Raj")
			new_game_op.execute

			Result := new_game_op.game.p1.get_name ~ "Phil"
			check Result end

			Result := new_game_op.game.p1.get_turn ~ true
			check Result end

			Result := new_game_op.game.p2.get_name ~ "Raj"
			check Result end

			Result := new_game_op.game.p2.get_turn ~ false
			check Result end

			new_game_op.game.history.remove
		end

		t02: BOOLEAN
		local
			new_game_op: NEW_GAME
			play_op: PLAY
		do
		    comment("t02: test the PLAY module")
			create new_game_op.make
			create play_op.make

			new_game_op.set_players ("Phil", "Raj")
			new_game_op.execute

			play_op.set ("Phil",1)
			play_op.execute

			Result := new_game_op.game.state.grid2d.item (1,1) ~ "X"
			check Result end

			play_op.set ("Raj",2)
			play_op.execute

			Result := new_game_op.game.state.grid2d.item (1,2) ~ "O"
			check Result end

			new_game_op.game.history.remove
		end

		t03: BOOLEAN
		local
			new_game_op: NEW_GAME
			play_op: PLAY
			play_again_op : PLAY_AGAIN
		do
		    comment("t03: test the PLAY_AGAIN module and Score")
			create new_game_op.make
			create play_op.make
			create play_again_op.make
			new_game_op.set_players ("Phil", "Raj")
			new_game_op.execute
			play_op.set ("Phil",1)
			play_op.execute
			play_op.set ("Raj",2)
			play_op.execute
			play_op.set ("Phil",4)
			play_op.execute
			play_op.set ("Raj",5)
			play_op.execute
			play_op.set ("Phil",7)
			play_op.execute
			Result := new_game_op.game.p1.get_score.out ~ "1"
			check Result end

            play_again_op.execute
			Result := new_game_op.game.p1.get_turn ~ false
			check Result end
			Result := new_game_op.game.p2.get_turn ~ true
			check Result end

			play_op.set ("Raj",8)
			play_op.execute
			Result := new_game_op.game.state.grid2d.item (3,2) ~ "O"
			check Result end

			new_game_op.game.history.remove
		end

		t04: BOOLEAN
		local
			new_game_op: NEW_GAME
			play_op: PLAY
		do
		    comment("t04: test the messages and instruction")
			create new_game_op.make
			create play_op.make
			new_game_op.set_players ("Phil", "Raj")
			new_game_op.execute
			play_op.set ("Phil",1)
			play_op.execute
			play_op.set ("Raj",2)
			play_op.execute
			play_op.set ("Phil",4)
			play_op.execute
			play_op.set ("Raj",5)
			play_op.execute
			play_op.set ("Phil",7)
			Result := new_game_op.game.message ~ "there is a winner: => "
			check Result end
			Result := new_game_op.game.instruction ~ "play again or start new game"
			check Result end
		end

feature -- failures

		tf1
		local
			new_game_op: NEW_GAME
		do
		    comment("tf1: bad input new_game (Phil, Phil)")
		    sub_comment("Precondition violated due to same players name")
		    sub_comment("Error - names of players must be differents")
			create new_game_op.make
			new_game_op.set_players ("Phil", "Phil") -- precondition not satisfied
		end

        tf2
		local
			new_game_op: NEW_GAME
		do
		    comment("tf2: bad input (#, 3Raj)")
		    sub_comment("Precondition violated as the first letter of players is not alpha")
		     sub_comment("Error - name must start with A-Z or a-z")
			create new_game_op.make
			new_game_op.set_players ("#", "3Raj") -- precondition not satisfied
		end

		tf3
		local
			new_game_op: NEW_GAME
			play_op: PLAY
		do
		    comment("tf3: bad input new_game (Phil, Raj) & play(Adam, 1)")
		    sub_comment("Precondition violated since adam is not a player")
		     sub_comment("Error - no such player")
			create new_game_op.make
			create play_op.make
			new_game_op.set_players ("Phil", "Raj")
			play_op.set("Adam",1) -- precondition not satisfied
		end

		tf4
		local
			new_game_op: NEW_GAME
			play_op: PLAY
		do
		    comment("tf4: trying to insert the symbol at the spot already taken")
		    sub_comment("Precondition violated as the desired spot is occupied")
		     sub_comment("Error - button already taken")
			create new_game_op.make
			create play_op.make
			new_game_op.set_players ("Phil", "Raj")
			play_op.set("Phil",1)
			play_op.execute
			play_op.set("Raj",1) -- precondition not satisfied
		end

end
