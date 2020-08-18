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
			add_boolean_case (agent t1)
		end

feature -- tests

--	some_node: NODE [STRING]

--	t0: BOOLEAN
--		local
--		do
--			create some_node.make ("Yay!", Void, Void)
--		end


	t1: BOOLEAN
		local
			node: NODE[detachable STRING]
			s: STRING
		do
			comment("t1: First test node")
			create node.make (Void, Void, Void)
			Result := node.element ~ Void
				and node.previous = Void
				and node.next = Void
			check Result end
			---
			node.set_element ("Yay!")
			if attached {STRING} node.element as e
			then
				s := e
			end
			Result := s ~ "Yay!"
		end



end

