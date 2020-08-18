note
	description : "test-array application root class"
	date        : "$Date: 2008-09-19 11:33:35 -0700 (Fri, 19 Sep 2008) $"
	revision    : "$Revision: 74752 $"

class
	APPLICATION
inherit
	ES_SUITE

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			add_test (create {TEST_ACCOUNT}.make)
--			show_errors
			show_browser
			run_espec
		end



end
