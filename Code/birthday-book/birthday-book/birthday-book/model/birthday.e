note
	description: "Summary description for {BIRTHDAY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BIRTHDAY

create
	make

feature {NONE} -- Initialization

	make(a_month:INTEGER; a_day: INTEGER)
			-- Initialization for `Current'.
		do
			month := a_month
			day := a_day
		end
feature
	day: INTEGER
	month: INTEGER

invariant
	1 <= month and month <= 12
	1 <= day and day <= 31
end
