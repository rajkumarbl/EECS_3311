note
	description: "[
		bank accounts for tracking the balance of a client.
		Maintains deposit and withdraw data.
		]"
	author: "JSO"
	date: "$Date$"
	revision: "$Revision$"

class ACCOUNT create
	make

feature {NONE} -- Initialization

	make(a_credit: INTEGER)
			-- create an account with `a_balance' and credit limet `a_credit'
		require
			credit_limit_non_negative:  a_credit >= 0
		do
			credit := a_credit
			create {LINKED_LIST[TRANSACTION]}deposits.make
			create {LINKED_LIST[TRANSACTION]}withdrawals.make
		ensure
			balance_and_credit_correct: balance = 0 and credit = a_credit
		end

feature {ANY} -- queries

	balance: INTEGER
		do
			Result := total_deposits - total_withdrawals
		ensure
			comment("see invariant for postcondition")
		end


	credit: INTEGER
		-- credit limit

	daily_max: INTEGER = 5000
		-- daily maximum on withdrawals

	total_deposits: INTEGER
		do
			from deposits.start
			until
				deposits.after
			loop
				Result := Result + deposits.item.value
				deposits.forth
			end
		ensure
			comment("see invariant for postcondition")
		end

	total_withdrawals: INTEGER
		do
			from withdrawals.start
			until
				withdrawals.after
			loop
				Result := Result + withdrawals.item.value
				withdrawals.forth
			end
		ensure
			comment("see invariant for postcondition")
		end

	withdraws_today: INTEGER
			-- Total withdrawals today
		local
			i: INTEGER
			today: DATE
		do
			from
				i := 1
				create today.make_now
			until
				i > withdraws_on (today).count
			loop
				Result := Result + withdraws_on(today)[i].value
				i := i + 1
			end
		ensure
			comment("see invariant")
		end

feature -- Commands

	deposit (a: INTEGER)
			-- deposit amount `a' into the account
		require
			not_too_small: a > 0
		local
			d: TRANSACTION
			date: DATE
		do
			create date.make_now
			create {TRANSACTION}d.make (a,date)
			deposits.extend (d)
		ensure
			increased: balance = old balance + a and credit = old credit
			imp_one_more: deposits.count = old deposits.count + 1
		end

	withdraw (a: INTEGER)
			-- withdraw amount `a' from account
		require
			not_too_small: a > 0
			not_too_big: a <= (balance + credit)
			daily_maximum: a <= daily_max - withdraws_today
		local
			w: TRANSACTION
			date: DATE
		do
			create date.make_now
			create {TRANSACTION}w.make (a,date)
			withdrawals.extend (w)
		ensure
			decreased: balance = old balance - a and credit = old credit
			imp_one_more: withdrawals.count = old withdrawals.count + 1
		end


feature {TELLER, ES_TEST} -- export to class TELLER
	deposit_on_date (a: INTEGER; a_date: DATE)
			-- deposit amount `a' into the account
		require
			not_too_small: a > 0
		local
			d: TRANSACTION
		do
			create {TRANSACTION}d.make (a,a_date)
			deposits.extend (d)
		ensure
			increased: balance = old balance + a and credit = old credit
			imp_one_more: deposits.count = old deposits.count + 1
		end

	withdraw_on_date (amount: INTEGER; date: DATE)
			-- withdraw  `amount' from account
		require
			not_too_small: amount > 0
			not_too_big: amount <= (balance + credit)
			date_not_void: date /= Void
		local
			w: TRANSACTION
		do
			create w.make (amount,date)
			withdrawals.extend (w)
		ensure
			decreased: balance = old balance - amount and credit = old credit
			imp_one_more: withdrawals.count = old withdrawals.count + 1
		end

	withdraws_on(d: DATE): ARRAY[TRANSACTION]
		local
			t: TRANSACTION
			i: INTEGER
		do
			create Result.make_empty
			Result.compare_objects -- comment out for test to fail
			from
				withdrawals.start
				i := 1
			until
				withdrawals.after
			loop
				if  withdrawals.item.date ~ d then
					t := withdrawals.item.deep_twin -- information hiding
					Result.force (t, i)
					i := i + 1
				end
--				i := i + 1
				withdrawals.forth
			end
		ensure
			comment("!t:withdrawals . t.date~d <=> Result.has(t)")
		end

feature {NONE} -- Implementation
	comment(s:STRING):BOOLEAN  do Result := true end

	deposits: LIST [TRANSACTION]

	withdrawals: LIST[TRANSACTION]


invariant
	comment("invariants for requirement R1")
	positive_balance: balance + credit >= 0
	credit_non_negative: credit >= 0
	comment("invariants for requirement R3")
	balance_consistent: balance = total_deposits - total_withdrawals
	comment("invariants for R5")
	max_daily_withdraws: 0 <= withdraws_today and withdraws_today <= daily_max
	comment("withdraws_today=(sum i| withdraws_on(today)[i].value")

end
