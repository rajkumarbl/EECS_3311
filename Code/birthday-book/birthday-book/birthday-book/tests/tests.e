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
			-- create test suite
		do
			add_boolean_case (agent t1)
		end

feature -- tests
	t1: BOOLEAN
		local
			d1,d2a, d2b: BIRTHDAY
			b: BIRTHDAY_BOOK
			a: ARRAY[STRING]
			l_name: STRING
			l_birthday: BIRTHDAY
		do
			comment("t1: test_add_birthday")
			create d1.make (01, 14) -- Jan 14
			create d2a.make (02, 17) -- Feb 17
			create d2b.make (02, 17)
			create b.make
			b.put ("Jack", d1)
			b.put ("Jill", d2a)
			Result := b.model.count = 2
				and b.model["Jack"] ~ d1
				and b.model["Jill"] ~ d2b
			check Result end
			b.put ("Max", d2b)
			assert_equal ("Max", b.model["Max"], d2b)
			a := b.remind (d2a)
			Result := a.count = 2
				and a.has ("Max")
				and a.has ("Jill")
				and not a.has ("Jack")
			check Result end
			across b.model as cursor loop
				l_name := cursor.item.first
				l_birthday := cursor.item.second
				check
				b.imp.has (l_name)
				and then b.imp[l_name] ~ l_birthday
				end
			end
		end

end
