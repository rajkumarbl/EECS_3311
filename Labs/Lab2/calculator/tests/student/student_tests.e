note
	description: "Summary description for {STUDENT_TESTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS

inherit
	ES_TEST

create
	make

feature {NONE} -- Initialization

	stack_type: STRING

	make
			-- Initialization for `Current'.
		do
			stack_type := "array"
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			--violation cases
			add_violation_case_with_tag ("valid_expression", agent t04)
		end

feature -- tests

	t1: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t1: (5 + 8) * (130 -90) + 1 - 89.89) unbalanced parenthesis")
			create e.make(stack_type)
			-- now some bad syntax, unbalanced parenthesis
			l_exp := "(5 + 8) * (130 -90) + 1 - 89.89)"
			Result :=  not e.is_valid (l_exp)
			-- so do not call e.evaluate
			check Result end
			Result := e.error_string (l_exp) ~ "parse error (Line 1, Column 1)"
			check Result end
		end
	t2: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t2: Evaluate ( ( 1 + 2 ) * ( 3 - 4) ) and ( ( 80 + 119.99 ) + ( 80.01 + 20 ) )")t1: BOOLEAN
		local
			new_game_op: NEW_GAME
		do
		    comment("t1: test the NEW_GAME module")
			create new_game_op.make
			new_game_op.set_players ("Phil", "Raj")
			new_game_op.execute

			Result := new_game_op.game.p1.get_name ~ "Phil"
			check Result end

			Result := new_game_op.game.p1.get_turn ~ true
			check Result end

			Result := new_game_op.game.p2.get_name ~ "Raj"
			check Result end

			Result := new_game_op.game.p2.get_turn ~ false
			check Result end
		end
			l_exp := "( ( 1 + 2 ) * ( 3 - 4) )"
			create e.make(stack_type)
			e.evaluate(l_exp)
			Result := e.value = -3
			check Result end
			--
			l_exp := "( ( 80 + 119.99 ) + ( 80.01 + 20 ) )"
			e.evaluate(l_exp)
			assert_equal ("error", "300", e.value.out)
			-- assert_equal uses string comparison, hence e.item.out
		end

		t3: BOOLEAN
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t3: Evaluate 30.55 and also error condition")
			l_exp := "30.55"
			create e.make(stack_type)
			e.evaluate(l_exp)
			Result := e.value ~ 30.55 and not e.error
			check Result end

			--bad syntax
			l_exp := "(99.80 + 54.66) * (33.06 * 22.890"
			create e.make(stack_type)
			if e.is_valid (l_exp) then
				e.evaluate(l_exp)
			end
			Result := e.error
		end

feature -- failures

	t04
		local
			l_exp: STRING
			e: EVALUATOR
		do
			comment("t04: bad syntax (1.0 + 2.0 * 3.0 / ( 6.0*6.0 + 5.0*44.0) ** 0.25)")
			sub_comment("Precondition of `evaluate' violated due to `**'")
			l_exp := "(1.0 + 2.0 * 3.0 / ( 6.0*6.0 + 5.0*44.0) ** 0.25)"
			create e.make("array")
			e.evaluate (l_exp)  -- precondition not satisfied
		end
end
