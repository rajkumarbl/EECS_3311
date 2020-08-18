note
	description: "an account deposit or withdrawal"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	TRANSACTION
inherit
	ANY
		redefine
			is_equal
		end
create
	make
feature {NONE}
	make (v: INTEGER; d: DATE)
			-- create a transaction with value `v' and date `d'
		do
			value := v
			date := d
		ensure
			value_set: value = v and date = d
		end
feature
	value: INTEGER

	date: DATE

	is_equal(other: like Current): BOOLEAN
		do
			Result := value = other.value and date ~ other.date
		end

invariant
	value >= 0 and date /= Void

end
