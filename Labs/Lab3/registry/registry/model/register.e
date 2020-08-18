note
	description: "Summary description for {REGISTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PERSON

inherit
	COMPARABLE
	   redefine
	    is_less
	    end


create {REGISRTY,ES_TEST}
	make

feature {NONE} -- Initialization
	make
			-- Initialization for `Current'.
		do
	    	create name.make_empty
			create dob.default_create
			create country.make_empty
			create status.make_empty
			create spouse_name.make_empty
			create spouse_id.default_create
			create marry_date.default_create


		end

feature -- model attributes

	name        : STRING
	id          : INTEGER_64
	dob         : TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]
	country     : STRING
	status      : STRING
	spouse_name : STRING
	spouse_id   : INTEGER_64
	marry_date  : TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64]

feature

	set_name(n:STRING)
	do
		name :=n
	end

	set_id(i:INTEGER_64)
	do
		id := i
	end

	set_country(c:STRING)
	do
		country := c
	end

	set_status(st:STRING)
	do
		status := st
	end

	set_dob(d:TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64])
	do
		dob := d
	end

	set_spouse_name(spn:STRING)
	do
		spouse_name := spn
	end

	set_spouse_id(spid:INTEGER_64)
	do
		spouse_id := spid
	end

	set_marry_date(d:TUPLE[d: INTEGER_64; m: INTEGER_64; y: INTEGER_64])
	do
		marry_date := d
	end


	is_less alias "<" (other: like Current): BOOLEAN
	do
		if Current.name /~ other.name then
			Result := Current.name < other.name
		else
        	Result := Current.ID < other.ID
		end
	end

invariant

	   name_country_is_not_void : name /= void and country /= void
	   dob_is_not_void          : dob /= void
end
