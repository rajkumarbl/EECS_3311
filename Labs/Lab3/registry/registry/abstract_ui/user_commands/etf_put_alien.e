note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_PUT_ALIEN
inherit
	ETF_PUT_ALIEN_INTERFACE
		redefine put_alien end
create
	make
feature -- command
	put_alien(id: INTEGER_64 ; name1: STRING ; dob: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64] ; country: STRING)
		require else
			put_alien_precond(id, name1, dob, country)
    	do
			-- perform some update on the model state
			if id <= 0  then
		   		model.set_err(model.err_id_nonpositive)
	 		else if model.registry.has (id) then
	 			model.set_err(model.err_id_taken)
		 	else if not name1.at(1).is_alpha then
	            model.set_err(model.err_name_start)
	        else if not country.at(1).is_alpha then
	            model.set_err(model.err_country_start)
		    else if dob.d>31 or dob.d<1 or dob.m>12 or dob.m<1 or dob.y>3000 or dob.y<1900 then
			   	model.set_err(model.err_invalid_date)
	        else if (dob.m ~1 or dob.m ~3 or dob.m ~ 5 or dob.m ~7 or dob.m ~8 or dob.m ~10 or dob.m ~12) and (dob.d  > 31 or dob.d < 1) then
		      	model.set_err(model.err_invalid_date)
		    else if (dob.m ~ 4 or dob.m ~ 6 or dob.m ~ 9 or dob.m ~ 11) and (dob.d  >= 31 or dob.d < 1) then
		     	model.set_err(model.err_invalid_date)
		    else if (dob.m ~ 2) and model.is_leap_year(dob.y) and (dob.d  > 29 or dob.d < 1) then
			   	model.set_err(model.err_invalid_date)
		    else if (dob.m ~ 2) and not model.is_leap_year(dob.y) and (dob.d  >= 29 or dob.d < 1) then
			    model.set_err(model.err_invalid_date)
		    else
		    model.set_err(model.err_success)
			model.put_alien (id, name1, dob, country)
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
