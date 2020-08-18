class
	TEST_ACCOUNT
inherit
	ES_TEST
create
	make
feature
	make
		-- create tests
		do
			add_boolean_case (agent test_create_account)
			add_boolean_case (agent test_deposit)
			add_boolean_case (agent test_withdraw)
			add_boolean_case (agent test_deposit_and_withdraw)
			add_boolean_case (agent test_transaction_value_and_date)
			add_boolean_case (agent test_transaction_value_and_date2)
			add_violation_case (agent test_withdraw_violation)
			add_violation_case_with_tag ("not_too_small", agent test_deposit_amount)
		end
feature

	test_create_account: BOOLEAN
		local
			a: ACCOUNT
		do
			comment("t0: test_create_account")
			check 500 + 1200 >= 0 end
			create a.make(1200)
			Result := a.balance = 0 and a.credit = 1200
			check Result end
		end

	test_withdraw: BOOLEAN
		local
			a: ACCOUNT
		do
			comment("t1: test_withdraw")
			create a.make (1200)
			a.withdraw (700)
			Result := a.balance = -700 and a.credit = 1200
		end


	test_deposit: BOOLEAN
			-- not a query; no return type
		local
			a: ACCOUNT
		do
			comment("t2: test_deposit")
			create a.make (1200)
			a.deposit (800)
			Result := a.balance = 800 and a.credit = 1200
		end



	test_deposit_and_withdraw: BOOLEAN
			-- not a query; no return type
		local
			a: ACCOUNT
		do
			comment("t4: test_deposit_and_withdraw")
			create a.make (0)
			Result := a.balance = 0 and a.total_deposits = 0 and a.total_withdrawals = 0
			check Result end
			a.deposit (800)
			a.deposit (400)
			a.withdraw (1200)
			Result := a.balance = 0 and a.total_deposits = 1200 and a.total_withdrawals = 1200
		end

	test_transaction_value_and_date: BOOLEAN
			-- not a query; no return type
		local
			a: ACCOUNT
			today,tomorrow: DATE
			withdraws_today:ARRAY[TRANSACTION]
			w1,w2,w3: TRANSACTION
			daily_max: INTEGER
		do
			comment("t5: test_transaction_value_and_date")
			daily_max := 5000
			create today.make_now
			create tomorrow.make_now; tomorrow.day_forth
			create a.make (0)
			a.deposit (daily_max + 500)
			check a.balance = 5500 end
			a.withdraw (1000)
			a.withdraw (4000)
			a.withdraw_on_date (400, tomorrow)
			Result := a.balance = 100
			check Result end
			Result := a.withdraws_today = 5000
			check Result end
			withdraws_today := a.withdraws_on (today)
			Result := withdraws_today.count = 2
			check Result end
			create w1.make (1000, today)
			create w2.make (4000, today)
			create w3.make (400, tomorrow)
			check Result end
			Result := withdraws_today.has (w1) and withdraws_today.has (w2) and not withdraws_today.has (w3)
		end

	test_transaction_value_and_date2: BOOLEAN
			-- not a query; no return type
		local
			a: ACCOUNT
			today,tomorrow: DATE
			today_withdraws:ARRAY[TRANSACTION]
			w1,w2,w3: TRANSACTION
		do
			comment("t6: test_transaction_value_and_date2")
			create today.make_now
			create tomorrow.make_now; tomorrow.day_forth
			create a.make (0)
			a.deposit (5500)
			check a.balance = 5500 end
			a.withdraw (1000)
			a.withdraw_on_date (400, tomorrow)
			a.withdraw (4000)
			Result := a.balance = 100
			check Result end
			Result := a.withdraws_today = 5000
			check Result end
			today_withdraws := a.withdraws_on (today)
			Result := today_withdraws.count = 2
			check Result end
			create w1.make (1000, today)
			create w2.make (4000, today)
			create w3.make (400, tomorrow)
			check Result end
			Result := today_withdraws.has (w1) and today_withdraws.has (w2) and not today_withdraws.has (w3)
		end

feature -- Violation Tests

	test_withdraw_violation
			-- not a query; no return type
		local
			a: ACCOUNT
		do
			comment("**t100: test_withdraw_violation")
			create a.make (600)
			a.deposit(100)
			a.withdraw (800)
			-- crash: precondition not satsified
		end

	test_deposit_amount
		local
			a: ACCOUNT
		do
			comment("**t101: test_deposit_amount violation")
			create a.make (500)
			a.deposit (-200)
			-- crash: precondition not satisfied
		end

end
