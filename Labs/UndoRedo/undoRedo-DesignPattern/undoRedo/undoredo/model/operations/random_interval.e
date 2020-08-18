note
	description: "[
		Generation of random integer numbers 
		over an integer range low .. high
		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RANDOM_INTERVAL
create
	make

feature {NONE}

	random: RANDOM

	make (low_limit: INTEGER; high_limit: INTEGER)
			-- create an integer interval
			-- `low_limit'..`high_limit'
			-- for the generation of ramdom numbers
		require
			low_limit <= high_limit
		do
			create random.make
			low := low_limit
			high := high_limit
			item :=low
		end

feature

	low, high: INTEGER
		-- integer interval low .. high

	generate
			-- generate a new random number `item'
			-- in interval low..high
		do
			random.forth
			real := random.real_item * (high - low + 1)
			item := real.truncated_to_integer + low
		ensure

		end

	real: REAL
		-- between 0 and 1

	item: INTEGER
		-- between low and hi

invariant
	low <= item and item <= high

end
