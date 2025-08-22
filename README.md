# EETM (Even Easier Table Management)
## Features:
- table creation/deletion/cloning
- sending, moving, destroying, cloning, modifying data
- debug helper functions and protected from unexpected/invalid datatypes

## Installation
to use EETM, download the zip file and place it into your project folder, then require the eetm.lua file
```lua
eetm = require("libraries.EETM.eetm")
```

## Functions
### Tables
- eetm.createTable() -- creates a table
```lua
newTable_index = eetm.createTable()
```
returns the index of the created table<br><br>

- eetm.deleteTable(ti) -- deletes the table with all its data
```lua
newTable_index = eetm.createTable()
eetm.deleteTable(newTable_index)
```
returns nothing<br><br>

- eetm.getTable(ti) -- returns the table
```lua
newTable_index = eetm.createTable()
newTable = eetm.getTable(newTable_index)
```
returns the table<br><br>

- eetm.clearTable(ti) -- clears the entire table
```lua
newTable_index = eetm.createTable()
eetm.sendData(newTable_index, "apple") -- apple is inside newTable
eetm.clearTable(newTable_index) -- apple no longer exists
```
returns nothing<br><br>

- eetm.getTableSize(t) -- returns the size of the table
```lua
newTable_index = eetm.createTable()
newTable = eetm.getTable(newTable_index)
eetm.sendData(newTable_index, "apple") -- apple is inside newTable
print(eetm.getTableSize(newTable))
--> 1
eetm.sendData(newTable_index, "banana") -- banana is inside newTable
print(eetm.getTableSize(newTable))
--> 2
```
returns the size of the table<br><br>

### Data
- eetm.sendData(ito, data) -- sends data to a table
```lua
newTable_index = eetm.createTable()
eetm.sendData(newTable_index, "mydata")
```
returns nothing<br><br>

- eetm.moveData(ifrom, ito) -- moves all data from one table to another
```lua
newTable1_index = eetm.createTable()
newTable2_index = eetm.createTable()
eetm.sendData(newTable_index, "apple") -- apple is inside newTable1
eetm.moveData(newTable_index, newTable2_index)
-- apple in now in newTable2
```
returns nothing<br><br>

- eetm.cloneData(ifrom, ito) -- clones data from one table to another
```lua
newTable1_index = eetm.createTable()
newTable2_index = eetm.createTable()
eetm.sendData(newTable_index, "apple") -- apple is inside newTable1
eetm.clone(newTable_index, newTable2_index)
-- apple is now in newTable1 and newTable2
```
returns nothing<br><br>

- eetm.destroyData(ifrom) -- destroys all data stored in a table
```lua
newTable_index = eetm.createTable()
eetm.sendData(newTable_index, "banana") -- banana is inside newTable
eetm.destroyData(newTable_index)
-- newTable is empty
```
returns nothing<br><br>

- eetm.modifySingle(ti, di, data) -- modifies a single data item
```lua
newTable_index = eetm.createTable()
eetm.sendData(newTable_index, "apple") -- apple is inside newTable
eetm.modifySingle(newTable_index, 1, "banana") -- apple changed to banana inside newTable
```
returns nothing<br><br>

- eetm.getSingle(ti, di) -- returns a single data item from a table
```lua
newTable_index = eetm.createTable()
eetm.sendData(newTable_index, "apple") -- apple is inside newTable
eetm.sendData(newTable_index, "banana") -- banana is inside newTable
print(eetm.getSingle(newTable_index, 1))
--> apple
print(eetm.getSingle(newTable_index, 2))
--> banana
```
returns the data that was stored there previously<br><br>

- eetm.getFirstSingle(t, val) -- find the first single with the same value
```lua
newTable_index = eetm.createTable()
newTable = eetm.getTable(newTable_index)
eetm.sendData(newTable_index, "banana")
eetm.sendData(newTable_index, "apple")
local fruit = "apple"
print(eetm.getFirstSingle(newTable, fruit))
--> apple
```
returns the first single with value=val or nil if no data is found<br><br>

- eetm.getFirstSingleOfType(t, _type) -- finds the first single of a specified type
```lua
newTable_index = eetm.createTable()
newTable = eetm.getTable(newTable_index)
eetm.sendData(newTable_index, "apple")
eetm.sendData(newTable_index, 2)
eetm.sendData(newTable_index, 3)
local wanted_type = "number"
print(eetm.getFirstSingleOfType(newTable, wanted_type))
--> 2
```
returns the first single with the type=_type or nil if no data is found<br><br>

### Protected functions
- eetm.protected.getTable(ti) -- returns a table or nil if doesn't find
```lua
newTable_index = eetm.createTable()
print(eetm.protected.getTable(newTable_index))
--> table: 01AB2345
```
```lua
print(eetm.protected.getTable(newTable_index))
--> nil
```
returns a table or nil if doesn't find<br><br>

- eetm.protected.getSingle(ti, di, expected_type, allow_unexpected) -- returns the single only if it's type matches the expected type(with allow_unexpected = false), allow_unexpected is true by default
```lua
newTable_index = eetm.createTable()
eetm.sendData(newTable_index, "apple")
print(eetm.protected.getSingle(newTable_index, 1, "string")) -- allow_unexpected is set to true by default
--> apple
```
```lua
newTable_index = eetm.createTable()
eetm.sendData(newTable_index, 5)
print(eetm.protected.getSingle(newTable_index, 1, "string")) -- allow_unexpected is set to true by default
--> 5
```
```lua
newTable_index = eetm.createTable()
eetm.sendData(newTable_index, 5)
print(eetm.protected.getSingle(newTable_index, 1, "string", false)) -- allow_unexpected is set to true by default
--> nil
```
returns the single only if it's type matches the expected type(with allow_unexpected = false)<br><br>

### Debug helper functions
- eetm.debug.printSingles(t) -- prints all singles to the console
```lua
newTable_index = eetm.createTable()
newTable = eetm.getTable(newTable_index)
eetm.sendData(newTable_index, "apple")
eetm.sendData(newTable_index, 5)
eetm.debug.printSingles(newTable)
--> apple
--> 5
```
returns nothing<br><br>

- eetm.debug.neatwriteSingles(t, include_types) -- neatly writes all singles into the console in a single line with their types(optional), the types are shortened to not overflow the console, include_types is false by default
```lua
newTable_index = eetm.createTable()
newTable = eetm.getTable(newTable_index)
eetm.sendData(newTable_index, "apple")
eetm.sendData(newTable_index, 5)
eetm.debug.neatwriteSingles(newTable)
--> apple, 5, 
```
```lua
newTable_index = eetm.createTable()
newTable = eetm.getTable(newTable_index)
eetm.sendData(newTable_index, "apple")
eetm.sendData(newTable_index, 5)
eetm.debug.neatwriteSingles(newTable, true)
--> apple(str), 5(num), 
```
All type abbreviations:
- nil - nil
- boolean - bool
- number - num
- string - str
- function - func
- userdata - usrd
- thread - thr
- table - tbl
- unknown - unkwn<br><br>
returns nothing<br><br>

## Function Parameters
list of all parameters used by functions
- ```ti``` - index of the table
- ```data``` - data you want to send
- ```ito``` - index of the table you send data to
- ```ifrom``` - index of the table you move data from
- ```di``` - index of the single data item
- ```t``` - table
- ```func``` - function
- ```val``` - value
- ```_type``` - data type
- ```expected_type``` - data type
- ```allow_unexpected``` - boolean
## License
This project is licensed under the MIT License.<br>
See the [LICENSE](LICENSE) file for more details.
