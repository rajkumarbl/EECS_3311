note
	description: "[
		STACK_LIST inherits complete contracts from ABTSRACT_STACK
		implemented with an ARRAY testable via ES_TEST
		  implementation: LIST [G]
		top of the stack is first element of the list
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STACK_LIST [G -> attached ANY]
inherit
	ANY
		undefine is_equal end
	ABSTRACT_STACK[G]
		redefine count end


create
	make

feature {NONE,ES_TEST} -- creation

	implementation: LINKED_LIST [G]
		-- implementation of stack as array

	make
			-- create an empty stack
		do
			create implementation.make

		end

feature -- model

	model: SEQ [G]
			-- abstraction function
		do
			create Result.make_empty
		    across implementation as imp loop
	       	Result.append (imp.item)
            end
		end

feature -- Queries

	count: INTEGER
			 -- number of items in stack
		do
			Result := model.count
		end

	top: G
		do
			Result := implementation [1]
			-- the above may not be correct

			-- TBD

		end

feature -- Commands

	push (x: G)
			-- push `x' on to the stack
		do
			implementation.put_front (x)

		end

	pop
		do
			implementation.start
			implementation.remove
		end

invariant
	same_count:
		model.count = implementation.count
	    equality: across 1 |..| count as i all
		model[i.item] ~ implementation[i.item]
	end
	comment("top of stack is model[1] and implementation[1]")
end
