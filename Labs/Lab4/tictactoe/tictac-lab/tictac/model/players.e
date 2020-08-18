note
	description: "Summary description for {PLAYERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PLAYER

create{ETF_MODEL}
	make

feature{NONE}
	make
	do
		create name.make_empty
		create score.default_create
		create symbol.make_empty
	end

feature{OPERATION} -- attr
	name: STRING
	score: INTEGER
	symbol: STRING
	turn: BOOLEAN
	went_first: BOOLEAN

feature-- queries

get_name: STRING
	do
		Result := name
	end

get_score: INTEGER
	do
		Result := score
	end

get_symbol: STRING
	do
		Result := symbol
	end

get_turn: BOOLEAN
	do
		Result := turn
	end

get_went_first: BOOLEAN
	do
		Result := went_first
	end

feature{OPERATION,ETF_MODEL}-- command

set_name(a_name: STRING)
	do
		name := a_name
	end

set_score(a_score: INTEGER)
	do
		score := a_score
	end

set_symbol(a_symbol: STRING)
	do
		symbol := a_symbol
	end

set_turn(a_turn: BOOLEAN)
	do
		turn := a_turn
	end

set_went_first(a_first: BOOLEAN)
	do
		went_first := a_first
	end

end
