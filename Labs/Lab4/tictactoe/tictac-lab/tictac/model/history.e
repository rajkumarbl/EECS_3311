note
	description: "History operations for undo/redo design pattern"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	HISTORY

create
	make

feature{STATE}
	make
		do
			create {ARRAYED_LIST[OPERATION]}history.make (10)
		end

feature -- history
	history: LIST[OPERATION]
		-- a history list of user invoked operations

	extend_history(a_op: OPERATION)
			-- remove all operations to the right of the current
			-- cursor in history, then extend with `a_op'
		do
			remove_right
			history.extend(a_op)
			history.finish
		ensure
			history[history.count] = a_op
		end

	remove_right
			--remove all elements
			-- to the right of the current cursor in history
		do
			if not history.islast and not history.after then
				from
					history.forth
				until
					history.after
				loop
					history.remove
				end
			end
		end

	remove
			--remove all elements
			-- to the right of the current cursor in history
		do
			  -- history.start
			if history.count > 0 then
			    from
					history.start
				until
					history.after
				loop
					history.remove
				end
			end
				history.start
		ensure
			history_reset:	history.count = 0
		end

	item: OPERATION
			-- Cursor points to this user operation
		require
			on_item
		do
			Result := history.item
		end

	get_count: STRING
		do
			Result := history.count.out
		end

	on_item: BOOLEAN
			-- cursor points to a valid operation
			-- cursor is not before or after
		do
			Result := history.valid_index (history.index)
		end

	forth
		do
			history.forth
		end

	back
		do
			history.back
		end

	not_last: BOOLEAN
		do
			Result := not history.is_empty and not history.islast
		end

end
