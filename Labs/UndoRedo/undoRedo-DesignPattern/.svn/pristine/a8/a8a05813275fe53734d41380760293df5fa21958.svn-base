note
	description: "Summary description for {TEST_RANDOM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RANDOM
inherit
	ES_TEST
create
	make

feature
	make
		do
			add_boolean_case (agent t1)
		end

feature -- tests
	t1: BOOLEAN
		local
			ri: RANDOM_INTERVAL
			index: INTEGER

		do
			comment("t1: test random numbers over an integer interval")
			create ri.make (1, 25)
			ri.generate
			index := ri.item
			Result := index = 7
			check result end
			ri.generate
			index := ri.item
			Result := index = 20
			check result end
			ri.generate
			index := ri.item
			Result := index = 15
			check result end
		end

end
