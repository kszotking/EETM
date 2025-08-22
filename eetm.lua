local eetm = {} -- core module
eetm.debug = {} -- submodule with debug functions
eetm.protected = {} -- submodule with built-in protections against nils or invalid/unexpected types
local bank = {}

local function determine_suffix(dt)
	local  suffix_index = 9
	if dt == "nil" then
		suffix_index = 1
	elseif dt == "boolean" then
		suffix_index = 2
	elseif dt == "number" then
		suffix_index = 3
	elseif dt == "string" then
		suffix_index = 4
	elseif dt == "function" then
		suffix_index = 5
	elseif dt == "userdata" then
		suffix_index = 6
	elseif dt == "thread" then
		suffix_index = 7
	elseif dt == "table" then
		suffix_index = 8
	end
	return suffix_index
end

function eetm.createTable() -- returns the index for later accessing/deleting the table
	local new_table = {}
	local index = 0
	table.insert(bank, new_table)
	return #bank
end

function eetm.deleteTable(ti) -- deletes the table with all its data
	table.remove(bank, index)
end

function eetm.sendData(ito, data) -- sends data to the table
	table.insert(bank[ito], data)
end

function eetm.moveData(ifrom, ito) -- moves data from one table to the second
	for _, v in pairs(bank[ifrom]) do
		table.insert(bank[ito], v)
	end
	for i = #bank[ifrom], 1, -1 do
		table.remove(bank[ifrom], i)
	end
end

function eetm.cloneData(ifrom, ito) -- clones data from a table without deleting it
	for _, v in pairs(bank[ifrom]) do
		table.insert(bank[ito], v)
	end
end

function eetm.destroyData(ifrom) -- destroys all data stored in a table
	for i = #bank[ifrom], 1, -1 do
		table.remove(bank[ifrom], i)
	end
end

function eetm.modifySingle(ti, di, data) -- modifies data in an existing table
	bank[ti][di] = data
end

function eetm.getTable(ti) -- returns a table
	return bank[ti]
end

function eetm.getSingle(ti, di) -- returns a single piece of data from a table
	return bank[ti][di]
end

function eetm.clearTable(ti) -- clears a table without deleting it
	for i = #bank[ti], 1, -1 do
		table.remove(bank[ti], i)
	end
end

function eetm.debug.printSingles(t) -- prints all singles to the console
	for _, v in pairs(t) do
		print(v)
	end
end

function eetm.debug.neatwriteSingles(t, include_types) -- neatly writes all singles in one line with their types(optional)
	local suffixes = {"nil", "bool", "num", "str", "func", "usrd", "thr", "tbl", "unkwn"}
	if include_types == nil then include_types = false end
	if not include_types then
		for _, v in pairs(t) do
			io.write(v..", ")
		end
	elseif include_types then
		for _, v in pairs(t) do
			io.write(v.."("..suffixes[determine_suffix(type(v))].."), ")
		end
	end
	io.write("\n")
end

function eetm.protected.getTable(ti) -- returns nil if doesn't find the table
	local t = nil
	if bank[ti] ~= nil then
		t = bank[ti]
	end
	return t
end

function eetm.protected.getSingle(ti, di, expected_type, allow_unexpected) -- returns nil if doesn't find the data or the data is an unexpected datatype with allow_unexpected set to false
	local data = nil
	if allow_unexpected == nil then allow_unexpected = true end
	if bank[ti] ~= nil then
		if bank[ti][di] ~= nil then
			if type(bank[ti][di]) == expected_type then
				data = bank[ti][di]
			elseif type(bank[ti][di]) ~= expected_type and allow_unexpected then
				data = bank[ti][di]
			end
		end
	end
	return data
end

function eetm.getFirstSingle(t, val) -- returns the first single data with a value=val in a table(nil if no data is found)
	local a = nil
	for _, v in pairs(t) do
		if v == val then
			a = v
			break
		end
	end
	return a
end

function eetm.getFirstSingleOfType(t, _type) -- returns the first single data with the type=_type in a table(nil if no data is found)
	local a = nil
	for _, v in pairs(t) do
		if type(v) == _type then
			a = v
			break
		end
	end
	return a
end

function eetm.getTableSize(t) -- returns the table size
	local count = 0
		for _, v in pairs(t) do
			count = count + 1
		end
	return count
end

return eetm
