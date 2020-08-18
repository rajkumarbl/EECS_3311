note
	description: "Summary description for {TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TESTS
inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent t0)
			add_violation_case (agent t1)
		end

feature -- tests
    n1:STRING = "<br/>"
	t0: BOOLEAN
	    local
	    	c : CALENDAR
	    	jan,feb,apr : INTEGER
		do
			comment("t0: Test Leap Year")
			create c
			sub_comment( n1 + "Test jan 2017 is 31 days")
			jan:=1
			Result := c.max_days(jan,2017)=31
			check Result end
			sub_comment( n1 + "Test Feb 2017 is 28 days")
			feb:=2
			Result := c.max_days(feb,2017)=28
			check Result end
			apr:=4
			assert_equal ("Test Apr 2017",c.max_days(apr,2017),30)
			assert_equal ("Test Feb 1904",c.max_days(feb,1904),29)
			assert_equal ("Test Feb 1900",c.max_days(feb,1900),28)
			assert_equal ("Test Feb 2000",c.max_days(feb,2000),29)
		end

	t1
	    local
	    	c: CALENDAR
	    	day: INTEGER
	    do
	    	comment("t1: test max_days precondition")
	    	create c
	    	day:= c.max_days(9,1583)
	    	--assert_equal("test", c.max_days (9,1584), 30)
	    end

end
