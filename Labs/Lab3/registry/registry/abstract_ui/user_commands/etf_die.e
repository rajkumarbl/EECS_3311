note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_DIE
inherit
	ETF_DIE_INTERFACE
		redefine die end
create
	make
feature -- command
	die(id: INTEGER_64)
		require else
			die_precond(id)
    	do
			-- perform some update on the model state
			if id <= 0  then
	    	    model.set_err(model.err_id_nonpositive)
	     	else if not model.registry.has (id) then
	     	 	model.set_err(model.err_id_unused)
	        else if not model.is_person_dead(id) then
	            model.set_err(model.err_dead_already)
	        else
	       	 	model.set_err(model.err_success)
				model.die (id)
			end
			end
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
