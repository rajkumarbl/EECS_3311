note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MARRY
inherit
	ETF_MARRY_INTERFACE
		redefine marry end
create
	make
feature -- command
	marry(id1: INTEGER_64 ; id2: INTEGER_64 ; date: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64])
		require else
			marry_precond(id1, id2, date)
    	do
    		 -- perform some update on the model state
    	     if id1 <= 0 or id2 <= 0 then
	    	    model.set_err(model.err_id_nonpositive)
	         else if id1 ~ id2 then
	    		model.set_err(model.err_id_same)
	     	 else if not model.registry.has (id1) or not model.registry.has (id2) then
	     	 	model.set_err(model.err_id_unused)
	     	 else if not model.is_legal_age (id1, id2) then
	            model.set_err(model.err_marry)
	         else if not model.is_marriage_valid (id1, id2) then
	            model.set_err(model.err_marry)
	         else if date.d>31 or date.d<1 or date.m>12 or date.m<1 or date.y>3000 or date.y<1900 then
                model.set_err(model.err_invalid_date)
             else if (date.m ~1 or date.m ~3 or date.m ~ 5 or date.m ~7 or date.m ~8 or date.m ~10 or date.m ~12) and (date.d  > 31 or date.d < 1) then
         		model.set_err(model.err_invalid_date)
         	 else if (date.m ~ 4 or date.m ~ 6 or date.m ~ 9 or date.m ~ 11) and (date.d  >= 31 or date.d < 1) then
         		model.set_err(model.err_invalid_date)
         	 else if (date.m ~ 2) and model.is_leap_year(date.y) and (date.d  > 29 or date.d < 1) then
         		model.set_err(model.err_invalid_date)
      	     else if (date.m ~ 2) and not model.is_leap_year(date.y) and (date.d  >= 29 or date.d < 1) then
         		model.set_err(model.err_invalid_date)
	         else
	         	model.set_err(model.err_success)
			    model.marry(id1, id2,date)
			 end
		  	 end
			 end
			 end
			 end
			 end
			 end
			 end
			 end
			 end
			 etf_cmd_container.on_change.notify ([Current])
    	end

end
