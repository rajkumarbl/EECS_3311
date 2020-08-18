class
 	 ETF_TYPE_CONSTRAINTS

feature -- type queries 

	is_direction(etf_v: INTEGER_64): BOOLEAN 
		require
			comment("etf_v: DIRECTION = {left, right, up, down}")
		do
			 Result := 
				(( etf_v ~ left ) or else ( etf_v ~ right ) or else ( etf_v ~ up ) or else ( etf_v ~ down ))
		ensure
			 Result = 
				(( etf_v ~ left ) or else ( etf_v ~ right ) or else ( etf_v ~ up ) or else ( etf_v ~ down ))
		end

feature -- constants for enumerated items 
	left: INTEGER =1
	right: INTEGER =2
	up: INTEGER =3
	down: INTEGER =4

feature -- list of enumeratd constants
	enum_items : HASH_TABLE[INTEGER, STRING]
		do
			create Result.make (10)
			Result.extend(1, "left")
			Result.extend(2, "right")
			Result.extend(3, "up")
			Result.extend(4, "down")
		end

	enum_items_inverse : HASH_TABLE[STRING, INTEGER_64]
		do
			create Result.make (10)
			Result.extend("left", 1)
			Result.extend("right", 2)
			Result.extend("up", 3)
			Result.extend("down", 4)
		end
feature -- query on declarations of event parameters
	evt_param_types_table : HASH_TABLE[HASH_TABLE[ETF_PARAM_TYPE, STRING], STRING]
		local
			restart_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			move_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			jump_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			undo_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
			redo_param_types: HASH_TABLE[ETF_PARAM_TYPE, STRING]
		do
			create Result.make (10)
			Result.compare_objects
			create restart_param_types.make (10)
			restart_param_types.compare_objects
			Result.extend (restart_param_types, "restart")
			create move_param_types.make (10)
			move_param_types.compare_objects
			move_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("DIRECTION", create {ETF_ENUM_PARAM}.make(<<"left", "right", "up", "down">>)), "a_direction")
			Result.extend (move_param_types, "move")
			create jump_param_types.make (10)
			jump_param_types.compare_objects
			Result.extend (jump_param_types, "jump")
			create undo_param_types.make (10)
			undo_param_types.compare_objects
			Result.extend (undo_param_types, "undo")
			create redo_param_types.make (10)
			redo_param_types.compare_objects
			Result.extend (redo_param_types, "redo")
		end
feature -- query on declarations of event parameters
	evt_param_types_list : HASH_TABLE[LINKED_LIST[ETF_PARAM_TYPE], STRING]
		local
			restart_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			move_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			jump_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			undo_param_types: LINKED_LIST[ETF_PARAM_TYPE]
			redo_param_types: LINKED_LIST[ETF_PARAM_TYPE]
		do
			create Result.make (10)
			Result.compare_objects
			create restart_param_types.make
			restart_param_types.compare_objects
			Result.extend (restart_param_types, "restart")
			create move_param_types.make
			move_param_types.compare_objects
			move_param_types.extend (create {ETF_NAMED_PARAM_TYPE}.make("DIRECTION", create {ETF_ENUM_PARAM}.make(<<"left", "right", "up", "down">>)))
			Result.extend (move_param_types, "move")
			create jump_param_types.make
			jump_param_types.compare_objects
			Result.extend (jump_param_types, "jump")
			create undo_param_types.make
			undo_param_types.compare_objects
			Result.extend (undo_param_types, "undo")
			create redo_param_types.make
			redo_param_types.compare_objects
			Result.extend (redo_param_types, "redo")
		end
feature -- comments for contracts
	comment(etf_s: STRING): BOOLEAN
		do
			Result := TRUE
		end
end