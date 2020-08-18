note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	REGISRTY

inherit
	ANY
		redefine
			out
		end

create {REGISTRY_ACCESS, ES_TEST}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do

			create registry.make(10)
			registry.compare_objects
		end

feature -- model attributes

	  registry    : HASH_TABLE[PERSON,INTEGER_64]

feature -- model operations
	default_update
			-- Perform update to the model state.
		do
			 -- i := i + 1
		end

	reset
			-- Reset model state.
		do
			make
		end

feature {ETF_COMMAND} -- Report

     error_msg : STRING
     attribute create Result.make_empty Result:="ok" end

     err_id_nonpositive : STRING
     attribute Result := "id must be positive" end

     err_id_unused : STRING
     attribute Result := "id not identified with a person in database" end

     err_id_same : STRING
     attribute Result := "ids must be different" end

     err_id_taken : STRING
     attribute Result := "id already taken" end

     err_name_start : STRING
     attribute Result := "name must start with A-Z or a-z" end

     err_country_start : STRING
     attribute Result := "country must start with A-Z or a-z" end

     err_invalid_date : STRING
     attribute Result := "not a valid date in 1900..3000" end

     err_marry : STRING
     attribute Result := "proposed marriage invalid" end

     err_divorce : STRING
     attribute Result := "these are not married" end

     err_dead_already : STRING
     attribute Result := "person with that id already dead" end

     err_success : STRING
     attribute Result := "ok" end

     set_err ( err: STRING)
     do
     	error_msg := err
     end

feature -- myfeature

     put(id: INTEGER_64 ; name1: STRING ; dob: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64])

     require
	      id_greater_than_zero : id > 0
	      id_not_taken_already : not registry.has (id)
	      name_start_proper    : name1.at(1).is_alpha
	      check_date_proper    : dob.d<=31 and dob.d>=1 and dob.m<=12 and dob.m>=1 and dob.y<=3000 and dob.y>=1900
	      check_no_of_days     : is_day_ok(dob)

     local
          p :PERSON

     do
	      create p.make
	      p.set_name (name1)
	   	  p.set_id (id)
	      p.set_dob (dob)
	      p.set_country ("Canada")
	      p.set_status ("Single")
	      registry.extend (p, id)

     end

     put_alien(id: INTEGER_64 ; name1: STRING ; dob: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64] ; country: STRING)

     require
	      id_greater_than_zero : id > 0
	      id_not_taken_already : not registry.has (id)
	      name_start_proper    : name1.at(1).is_alpha
	      country_start_proper : country.at(1).is_alpha
	      check_date_proper    : dob.d<=31 and dob.d>=1 and dob.m<=12 and dob.m>=1 and dob.y<=3000 and dob.y>=1900
	      check_no_of_days     : is_day_ok(dob)

     local
          r :PERSON
     do
	      create r.make
	      r.set_name (name1)
	      r.set_id (id)
	   	  r.set_dob (dob)
	      r.set_country (country)
	      r.set_status ("Single")
	      registry.extend (r, id)

     end

     marry(id1: INTEGER_64 ; id2: INTEGER_64 ; date: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64])

     require
	      id_greater_than_zero : id1 > 0 and id2 > 0
	      id_must_be_different : id1 /~ id2
	      id_not_taken_already : registry.has (id1) and registry.has (id2)
	      legal_age_of_pair    : is_legal_age(id1,id2)
	      marriage_is_valid    : is_marriage_valid(id1,id2)
	      check_date_proper    : date.d<=31 and date.d>=1 and date.m<=12 and date.m>=1 and date.y<=3000 and date.y>=1900
	      check_no_of_days     : is_day_ok(date)

     local
	      person1      : PERSON
		  person2      : PERSON
		  mydate         : STRING

	 do
	 	  person1:=registry.item (id1)
    	  person2:=registry.item (id2)

          check attached person1 as p1 and attached person2 as p2 then
          create mydate.make_empty
	      if date.m < 10 and date.d < 10 then mydate.append("["+date.y.out+"-0"+date.m.out+"-0"+date.d.out+"]")
		  else if date.d < 10 then mydate.append("["+date.y.out+"-"+date.m.out+"-0"+date.d.out+"]")
		  else if date.m < 10 then mydate.append("["+date.y.out+"-0"+date.m.out+"-"+date.d.out+"]")
		  else mydate.append("["+date.y.out+"-"+date.m.out+"-"+date.d.out+"]")  end end end
	      p1.set_spouse_id (id2)
		  p2.set_spouse_id (id1)
		  p1.set_status ("Spouse: "+p2.name+","+id2.out+","+mydate)
		  p2.set_status ("Spouse: "+p1.name+","+id1.out+","+mydate)
		  p1.set_spouse_name (p2.name)
		  p2.set_spouse_name (p1.name)
		  p1.set_marry_date (date)
		  p2.set_marry_date (date)
		  end
	 end



     divorce(a_id1: INTEGER_64 ; a_id2: INTEGER_64)
     require
	    id_greater_than_zero : a_id1 > 0 and a_id2 > 0
	    id_must_be_different : a_id1 /~ a_id2
	    id_not_taken_already : registry.has (a_id1) and registry.has (a_id2)
	    divorce_is_valid    : is_divorce_valid(a_id1,a_id2)


     local
		person1: PERSON
		person2: PERSON
		mydate: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]
     do
     	 person1:=registry.item (a_id1)
		 person2:=registry.item (a_id2)
		 create mydate.default_create
         check attached person1 as p1 and attached person2 as p2 then
	     p1.set_status ("Single")
	  	 p1.set_spouse_id (0)
		 p1.set_spouse_name ("")
		 p1.set_marry_date (mydate)
	     p2.set_status ("Single")
		 p2.set_spouse_id (0)
		 p2.set_spouse_name ("")
		 p2.set_marry_date (mydate)
	     end
     end

     die(id: INTEGER_64)

      require
	    id_greater_than_zero : id > 0
	    id_not_taken_already : registry.has (id)
	    check_person_alive   : is_person_dead(id)

      local
		person  : PERSON
		person2 : PERSON
		spid    : INTEGER_64
		mydate: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]

      do
        person := registry.item (id)
        create mydate.default_create
       	check attached person as p  then
       	if p.status /~ "Single" then
	    	spid := p.spouse_id
			person2 := registry.item (spid)
			check attached person2 as p2  then
			  p2.set_status ("Single")
			  p2.set_spouse_id (0)
			  p2.set_spouse_name ("")
		      p2.set_marry_date (mydate)
			  end
		end
		p.set_status ("Deceased")
		end
     end

     is_legal_age (id1:INTEGER_64; id2:INTEGER_64) : BOOLEAN
     local
     person1      : PERSON
     person2      : PERSON
     current_date : DATE_TIME
	 do
	 	  person1:=registry.item (id1)
    	  person2:=registry.item (id2)
          check attached person1 as p1 and attached person2 as p2 then
          create current_date.make_now
		  if (current_date.year - p1.dob.y) < 18 or (current_date.year - p2.dob.y) < 18 then
	      	Result := false
	      else
	      	Result := true
	      end
	      end
     end

     is_person_dead (id1:INTEGER_64) : BOOLEAN
     local
     person1      : PERSON
	 do
	 	  person1:=registry.item (id1)
          check attached person1 as p1 then
		  if p1.status ~ "Deceased" then
	      	Result := false
	      else
	      	Result := true
	      end
	      end
     end

     is_marriage_valid (id1:INTEGER_64; id2:INTEGER_64) : BOOLEAN
     local
     person1      : PERSON
     person2      : PERSON
	 do
	 	  person1:=registry.item (id1)
    	  person2:=registry.item (id2)
          check attached person1 as p1 and attached person2 as p2 then
		  if (p1.country /~ "Canada" and p2.country /~ "Canada") or (p1.status ~ "Deceased" or p2.status ~ "Deceased" or p1.status /~ "Single" or p2.status /~ "Single" ) then
	     	Result := false
	      else
	      	Result := true
	      end
	      end
     end

     is_divorce_valid (id1:INTEGER_64; id2:INTEGER_64) : BOOLEAN
     local
     person1      : PERSON
     person2      : PERSON
	 do
	 	  person1:=registry.item (id1)
    	  person2:=registry.item (id2)
          check attached person1 as p1 and attached person2 as p2 then
		  if p1.status ~ "Single" or p1.status ~ "Deceased" or p1.spouse_id /~ id2 or p2.spouse_id /~ id1 or p2.status ~ "Single" or p2.status ~ "Deceased" then
	     	Result := false
	      else
	      	Result := true
	      end
	      end
     end

     is_day_ok (date: TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]) : BOOLEAN
     do
     	if (date.m ~1 or date.m ~3 or date.m ~ 5 or date.m ~7 or date.m ~8 or date.m ~10 or date.m ~12) and (date.d  > 31 or date.d < 1) then
     		Result := false
     	else if (date.m ~ 4 or date.m ~ 6 or date.m ~ 9 or date.m ~ 11) and (date.d  >= 31 or date.d < 1) then
     		Result := false
     	else if (date.m ~ 2) and is_leap_year(date.y) and (date.d  > 29 or date.d < 1) then
     	 	Result := false
     	else if (date.m ~ 2) and not is_leap_year(date.y) and (date.d  >= 29 or date.d < 1) then
     		Result := false
        else
        	Result := true
     	end
     	end
     	end
     	end
     end


     is_leap_year(y: INTEGER_64): BOOLEAN
        require
        	y > 1584

        do
        	if (y \\ 4) = 0
        	and ((y \\ 100) /=0 or (y\\400) = 0)
            then
        		Result := True
        	end
        ensure
        	    Result = ( mod(y,4) = 0
        	        and mod(y,400) /=100
        	        and mod(y,400) /=200
        	        and mod(y,400) /=300
        	        )
        end
     mod(a,b: INTEGER_64): INTEGER_64
        do
        	Result := a\\b
        end

feature -- queries

	out : STRING
		local
		   	pname   : STRING
			id      : INTEGER_64
			dob     : TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]
			country : STRING
			status  : STRING
			date    : STRING
			sorted_persons: SORTED_TWO_WAY_LIST[PERSON]
	    do
	    	    create sorted_persons.make
	    	    sorted_persons.compare_objects
	    	    across registry as r loop sorted_persons.extend (r.item)  end
			    create Result.make_from_string ("  ")
			    Result.append (error_msg)
	            across
				sorted_persons as c
	            loop
					pname   := c.item.name
					id      := c.item.id
					dob     := c.item.dob
					country := c.item.country
					status  := c.item.status
					create date.make_empty
					check attached dob as d then
					if d.m < 10 and d.d < 10 then date.append(d.y.out+"-0"+d.m.out+"-0"+d.d.out)
					else if d.d < 10 then date.append(d.y.out+"-"+d.m.out+"-0"+d.d.out)
					else if d.m < 10 then date.append(d.y.out+"-0"+d.m.out+"-"+d.d.out)
					else date.append(d.y.out+"-"+d.m.out+"-"+d.d.out)  end end end
				    end
					Result.append ("%N"+"  "+pname+"; ID: "+id.out+"; Born: "+date+"; Citizen: "+country+"; "+status)
				end
		end
end




