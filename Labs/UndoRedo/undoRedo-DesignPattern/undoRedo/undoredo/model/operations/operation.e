note
	description: "Summary description for {OPERATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OPERATION
feature
	state: STATE
		local
			ma: GAME_ACCESS
		once
			Result := ma.game.state
		end

	game: GAME
		local
			ma: GAME_ACCESS
		once
			Result := ma.game
		end

	item: STRING
		-- operation at the UI: e.g. move(direction)

	execute
		deferred
		end
	undo
		deferred
		end

	redo
		deferred
		end

end
