note
	description: "Summary description for {STUDENT_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS

inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization



	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
		end

feature -- tests

	    t1: BOOLEAN
		local
			register : REGISRTY
			dob      : TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]
            myname   : STRING
		do
			comment("t1: test the put method")
			create register.make
			create dob.default_create
			dob.d := 27
			dob.m := 06
			dob.y := 1996
            register.put(1,"Raj",dob)
            register.put(2,"kumar",dob)
            check attached register.registry.at(1) as r then
            	check attached r.name as rr then myname := rr end
             end
			Result := myname ~ "Raj"
			check Result end
		end

		t2: BOOLEAN
		local
			register : REGISRTY
			dob      : TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]
            myname   : STRING
            mycountry: STRING
		do
			comment("t2: test the put_alien method")
			create register.make
			create dob.default_create
			dob.d := 27
			dob.m := 06
			dob.y := 1996
            register.put_alien(1,"Raj",dob,"India")
            check attached register.registry.at(1) as r then
            	check attached r.name as rr and attached r.country as rc then myname := rr mycountry := rc end
             end
			Result := myname ~ "Raj"
			check Result end
			Result := mycountry ~ "India"
			check Result end
		end

			t3: BOOLEAN
			local
				register : REGISRTY
				dob      : TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]
				mdate    : TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]
	            sp1      : STRING
	            sp2      : STRING
			do
				comment("t3: test the marry method")
				create register.make
				create dob.default_create
				create mdate.default_create
				dob.d := 27	dob.m := 06		dob.y := 1996
				mdate.d := 15 mdate.m := 02  mdate.y := 2017
	            register.put_alien(1,"Raj",dob,"India")
	            register.put (2,"Manika",dob)
	            register.marry (1,2,mdate)
	            check attached register.registry.at(1) as r and attached register.registry.at(2) as r2  then
	            	check attached r.spouse_name as rn and attached r2.spouse_name as rn2 then sp1 := rn sp2 := rn2 end
	             end
				Result := sp1 ~ "Manika"
				check Result end
				Result := sp2 ~ "Raj"
				check Result end
			end

			t4: BOOLEAN
			local
				register : REGISRTY
				dob      : TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]
				mdate    : TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]
	            sp1      : STRING
	            sp2      : STRING
			do
				comment("t4: test the divorce method")
				create register.make
				create dob.default_create
				create mdate.default_create
				dob.d := 27	dob.m := 06		dob.y := 1996
				mdate.d := 15 mdate.m := 02  mdate.y := 2017
	            register.put_alien(1,"Raj",dob,"India")
	            register.put (2,"Manika",dob)
	            register.marry (1,2,mdate)
	            register.divorce (1,2)
	            check attached register.registry.at(1) as r and attached register.registry.at(2) as r2  then
	            	check attached r.status as rn and attached r2.status as rn2 then sp1 := rn sp2 := rn2 end
	             end
				Result := sp1 ~ "Single"
				check Result end
				Result := sp2 ~ "Single"
				check Result end
			end

		t5: BOOLEAN
		local
			register : REGISRTY
			dob      : TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]
            mystatus   : STRING
		do
			comment("t5: test the die method")
			create register.make
			create dob.default_create
			dob.d := 27
			dob.m := 06
			dob.y := 1996
            register.put(1,"Raj",dob)
            register.put(2,"kumar",dob)
            register.die (1)
            check attached register.registry.at(1) as r then
            	check attached r.status as rr then mystatus := rr end
             end
			Result := mystatus ~ "Deceased"
			check Result end
		end




feature -- failures


end
