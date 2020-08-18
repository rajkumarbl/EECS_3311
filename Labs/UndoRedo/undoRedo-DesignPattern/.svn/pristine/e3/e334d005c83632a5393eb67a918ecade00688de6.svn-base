note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ETF_MOVE_INTERFACE
inherit
	ETF_COMMAND
		redefine 
			make 
		end

feature {NONE} -- Initialization

	make(an_etf_cmd_name: STRING; etf_cmd_args: TUPLE; an_etf_cmd_container: ETF_ABSTRACT_UI_INTERFACE)
		do
			Precursor(an_etf_cmd_name,etf_cmd_args,an_etf_cmd_container)
			etf_cmd_routine := agent move(?)
			etf_cmd_routine.set_operands (etf_cmd_args)
			if
				attached {INTEGER_64} etf_cmd_args[1] as a_direction
			then
				out := "move(" + etf_event_argument_out("move", "a_direction", a_direction) + ")"
			else
				etf_cmd_error := True
			end
		end

feature -- command precondition 
	move_precond(a_direction: INTEGER_64): BOOLEAN
		do  
			Result := 
				         is_direction(a_direction)
					-- (( a_direction ~ left ) or else ( a_direction ~ right ) or else ( a_direction ~ up ) or else ( a_direction ~ down ))
		ensure then  
			Result = 
				         is_direction(a_direction)
					-- (( a_direction ~ left ) or else ( a_direction ~ right ) or else ( a_direction ~ up ) or else ( a_direction ~ down ))
		end 
feature -- command 
	move(a_direction: INTEGER_64)
		require 
			move_precond(a_direction)
    	deferred
    	end
end
