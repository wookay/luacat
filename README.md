luacat
======

unit testing, logger, OOP, string, table extensions for lua.


Unit Testing
------------

```lua
package.path = package.path .. ";../luacat/?.lua"
require 'luacat'
function test_luacat()
	assert_equal(0, 0)
end
if is_main() then
	UnitTest.run()
end
```

	$ lua test_luacat.lua
	Started
	.
	Finished in 0.0001 seconds.
	1 tests, 1 assertions, 0 failures, 0 errors


Logger
------

```lua
  log_info( 123 )
  log_info( "abc" )
  log_info( {1, 2, 3} )
  log_info( {a = 1, b = 2} )
  log_info( "test %d %s", 123, "abc")
```

	test_logger.lua:9       123
	test_logger.lua:10      abc
	test_logger.lua:11      {1, 2, 3}
	test_logger.lua:12      {a = 1, b = 2}
	test_logger.lua:13      test 123 abc


OOP
---

```lua
  local A = extends(Object)
  function A.initialize(self)
    self.counter = 0
  end
  function A.plus_one(self)
    self.counter = self.counter + 1
  end
  local a = A.new()
  assert_equal(0, a.counter)
  a.plus_one()
  assert_equal(1, a.counter)
```

Extensions
----------
String, Table, Number, Date extensions.
see TestCases.


Moai Extensions
---------------
luacat has also included moacat, for Moai <http://getmoai.com/> extensions.
see MoacatTestCases.


Feedback
--------
 * Subscribe to google groups <http://groups.google.com/group/luacat>
