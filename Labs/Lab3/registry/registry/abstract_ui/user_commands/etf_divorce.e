note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_DIVORCE
inherit
	ETF_DIVORCE_INTERFACE
		redefine divorce end
create
	make
feature -- command

	divorce(a_id1: INTEGER_64 ; a_id2: INTEGER_64)
		require else
			divorce_precond(a_id1, a_id2)
    	do
			-- perform some update on the model state
			if a_id1 <= 0 or a_id2 <= 0 then
	    	    model.set_err(model.err_id_nonpositive)
	        else if a_id1 ~ a_id2 then
	    		model.set_err(model.err_id_same)
	     	else if not model.registry.has (a_id1) or not model.registry.has (a_id2) then
	     	 	model.set_err(model.err_id_unused)
	        else if not model.is_divorce_valid (a_id1, a_id2) then
	            model.set_err(model.err_divorce)
	        else
	       	 	model.set_err(model.err_success)
				model.divorce (a_id1, a_id2)
			end
			end
			end
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
