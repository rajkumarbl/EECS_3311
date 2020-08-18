note
	description: "Summary description for {CALENDAR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALENDAR

feature

	max_days(m: INTEGER; y: INTEGER): INTEGER
	        -- Maximum days in month 'm' in year 'y'
	    require
	    	1 <= m and m <= 12
            y >= 1584

        do
        	inspect m
        	when 1,3,5,7,8,10,12  then
                 Result := 31
        	when 4,6,9,11 then
        		Result := 30
        	else
                Result := (if is_leap_year(y) then 29 else 28 end)
            end
        end

    is_leap_year(y: INTEGER): BOOLEAN
        require
        	y > 1584

        do
        	if (y \\ 4) = 0
        	and ((y \\ 100) /=0 or (y\\400) = 0)
            then
        		Result := True
        	end
        ensure
        	    Result = ( mod(y,4) = 0
        	        and mod(y,400) /=100
        	        and mod(y,400) /=200
        	        and mod(y,400) /=300
        	        )
        end
     mod(a,b: INTEGER): INTEGER
        do
        	Result := a\\b
        end
end
