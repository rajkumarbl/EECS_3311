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

	make
			-- Initialization for `Current'.
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_violation_case (agent t5v)
			add_violation_case (agent t6v)
			add_violation_case (agent t7v)
		end

feature -- boolean cases
    t1: BOOLEAN
        local
            list1: DOUBLY_LINKED_LIST[STRING]
            list2: STRING
            r1:    STRING
        do
        	comment("t1: test debug_output")
			create list1.make_empty
			list1.add_first("Raj")
			list1.add_first ("Kumar")
			list1.add_first ("Rohin")
			list1.add_first ("Sibhi")
			list1.add_first ("Rahul")
			list2 :="{Rahul,Sibhi,Rohin,Kumar,Raj}"
			r1:= list1.debug_output
			Result:= r1 ~ list2
			check Result end
        end

      t2: BOOLEAN
        local
            list1, list2: DOUBLY_LINKED_LIST[STRING]
            n04 ,n03 ,n02 ,n01: NODE[STRING]
        do
        	comment("t2: test add_between")
			create list1.make_empty

			list1.add_first("Raj")
			check attached  list1.header.next as list1hn then
				n04 := list1hn
            end
			list1.add_first ("Kumar")
			check attached  list1.header.next as list1hn then
				n03 := list1hn
            end
			list1.add_first ("Sibhi")
			check attached  list1.header.next as list1hn then
				n02 := list1hn
            end
			list1.add_first ("Rahul")
			check attached  list1.header.next as list1hn then
				n01 := list1hn
            end

			create list2.make_from_array (<<"Rahul", "Sibhi", "Kumar", "Raj">>)
	    	Result := list1 ~ list2
			check Result end

			list1.add_between ("Rohin", n02, n03)
			create list2.make_from_array (<<"Rahul", "Sibhi", "Rohin", "Kumar", "Raj">>)
			assert_equal ("list1 ~ Rahul->Sibhi->Rohin->Kumar->Raj", list1, list2)

        end

     t3: BOOLEAN
        local
            list1, list2: DOUBLY_LINKED_LIST[DOUBLE]

        do
        	comment("t3: test doubly linked list with doubles and test for node structure")
        	sub_comment("<br>" + "test item, node, count")
			create list1.make_empty
			list1.add_first(50.50)
			list1.add_first (40.50)
			list1.add_first (30.50)
			list1.add_first (20.50)
			list1.add_first (10.50)

			create list2.make_from_array (<<10.50,20.50,30.50,40.50,50.50>>)
			Result:= list1 ~ list2
			check Result end

			Result := list1[1] ~ 10.50 and list1[2] ~ 20.50 and list1[3] ~ 30.50 and list1[4] ~ 40.50 and list1[5] ~ 50.50
			check Result end
			assert_equal ("count correct", list1.count, 5)
        end

       t4: BOOLEAN
        local
           list1, list2: DOUBLY_LINKED_LIST[STRING]

        do
        	comment("t4: test remove_last")
			create list1.make_empty
			list1.add_first("Raj")
			list1.add_first ("Kumar")
			list1.add_first ("Rohin")
			list1.add_first ("Sibhi")
			list1.add_first ("Rahul")


			list1.remove_last
			create list2.make_from_array (<<"Rahul", "Sibhi", "Rohin", "Kumar">>)
			Result := list1 ~ list2
			check Result end

			list1.remove_last
			create list2.make_from_array (<<"Rahul", "Sibhi", "Rohin">>)
			assert_equal ("list ~ {Rahul,Sibhi,Rohin}", list1, list2)

			list1.remove_last
			create list2.make_from_array (<<"Rahul", "Sibhi">>)
			assert_equal ("list ~ {Rahul,Sibhi}", list1, list2)

			list1.remove_last
			create list2.make_from_array (<<"Rahul">>)
			assert_equal ("list ~ {Rahul}", list1, list2)

			list1.remove_last
			create list2.make_from_array (<<>>)
			assert_equal ("list ~ {}", list1, list2)

		end


feature -- violation cases
	t5v
		local
			list1: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t5v: replace invalid index precondition violation")
			create list1.make_empty
			list1.add_first("Raj")
			list1.add_first ("Kumar")
			list1.add_first ("Rohin")
			list1.add_first ("Sibhi")
			list1.add_first ("Rahul")
			list1.replace("Lingam", 7)
		end

	t6v
		local
			list1: DOUBLY_LINKED_LIST[STRING]
		do
			comment("t6v: add_at(i) invalid index precondition violation")
			create list1.make_empty
			list1.add_first("Raj")
			list1.add_first ("Kumar")
			list1.add_first ("Rohin")
			list1.add_first ("Sibhi")
			list1.add_first ("Rahul")
			list1.add("Lingam", 7)
		end

	t7v
		local
		 list1: DOUBLY_LINKED_LIST[INTEGER]

		do
			comment("t7v: test add_between two nodes not adjacent Precondition violation")
			create list1.make_empty
			list1.add_first(7)
			list1.add_first(6)
			list1.add_first(5)

	    	list1.add_first(3)
	    	list1.add_first(2)
	    	list1.add_first(1)

	    	list1.add_between (4, list1.node (2), list1.node(5))
		end

end

