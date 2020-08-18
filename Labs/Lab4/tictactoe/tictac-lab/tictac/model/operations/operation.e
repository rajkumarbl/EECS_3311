note
	description: "Summary description for {OPERATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OPERATION
feature
	game: ETF_MODEL
		local
			ma: ETF_MODEL_ACCESS
		once
			Result := ma.m
		end

	stored_message: STRING
		-- operation at the UI: e.g. ok: =>
	stored_instruction: STRING
		-- instruction after message: e.g. player1 plays next

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
