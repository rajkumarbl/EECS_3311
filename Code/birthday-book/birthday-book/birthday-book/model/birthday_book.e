note
	description: "[
			Keep track of birthdays for friends
		]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class
	BIRTHDAY_BOOK

create
	make

feature {NONE, ES_TEST} -- implementation
	imp: HASH_TABLE[BIRTHDAY, STRING]
		-- imp: STRING --> DATE

	make
			-- create a birthday book
		do
			create imp.make (10)
		ensure
			model.is_empty
		end

feature -- model
	model: FUN[STRING, BIRTHDAY]
			-- model is a function from NAME --> BIRTHDAY
			-- we use STRING for names
			-- abstraction function
		local
			l_name: STRING
			l_date: BIRTHDAY
		do
			create Result.make_empty
			from
				imp.start
			until
				imp.after
			loop
				l_name := imp.key_for_iteration
				l_date := imp[l_name]
				check attached l_date as l_date2 then
					Result.extend ([l_name, l_date2])
				end
				imp.forth
			end
			imp.start
		end

feature
	put(a_name: STRING; d: BIRTHDAY)
			-- add date of birth for `a_name' at date `d'
			-- or overrride current birthday with new
		do
			if not model.domain.has (a_name) then
				imp.extend (d, a_name)
			else
				imp.replace (d, a_name)
			end
		ensure
			model_override:
				model ~ (old model @<+ [a_name,d])
		end

	remind(d: BIRTHDAY): ARRAY[STRING]
			-- returns an array of names with birthday `d'
		local
			l_name: STRING
			l_date: BIRTHDAY
			i: INTEGER
			m: ARRAY[STRING]
			j: INTEGER
		do

			create Result.make_empty
			Result.compare_objects
			from
				imp.start
			until
				imp.after
			loop
				l_name := imp.key_for_iteration
				l_date := imp[l_name]
				if
					l_date ~ d
				then
					Result.force (l_name, i)
					i := i + 1
				end
				imp.forth
			end
			m := (model @> (d)).domain
		ensure
			remind_count:
				Result.count = (model @> (d)).count
			remind_model_range_restiction:
				across (model @> (d)).domain as cr all
					Result.has(cr.item)
				end
		end

invariant
	model.count = imp.count
	across model as cursor all
		imp.has (cursor.item.first)
		and imp[cursor.item.first] ~ cursor.item.second
	end
end
