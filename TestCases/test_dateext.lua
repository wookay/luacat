-- test_dateext.lua
--                           wookay.noh at gmail.com

package.path = package.path .. ";../luacat/?.lua"
require 'UnitTest'
require 'DateExt'

function test_date()

  local date = Date.new(2010,1,1)
  assert_equal(2010, date.year)
  assert_equal(1, date.month)
  assert_equal(1, date.day)
  assert_equal(0, date.hour)
  assert_equal(0, date.min)
  assert_equal(0, date.sec)

  local yesterday = date.yesterday
  assert_equal(2009, yesterday.year)
  assert_equal(12, yesterday.month)
  assert_equal(31, yesterday.day)

  assert_equal(date, yesterday.tomorrow)
  assert_equal(86400, _(1).days)
  assert_equal(yesterday, date.before(_(1).days))
  assert_equal(date, yesterday.after(_(1).days))

  local today = Date.today()
  local diff = today - date
  local days_repr = time_interval_to_days(diff)
  assert_one_of(Table.keys(days_repr), 'days')

  assert_true(2011 <= today.year)
  assert_true(date < today)
  assert_true(date <= today)
  assert_false(date > today)
  assert_false(date >= today)
  assert_false(date == today)
  assert_true(date ~= today)

  assert_equal(_(24).hours, _(1).days)
  assert_equal(_(60).minutes, _(1).hours)
  assert_equal(_(60).seconds, _(1).minutes)

  assert_one_of(_(date).methods(), 'today')
  assert_one_of(_(date).methods(), 'before')

end

function test_time()
  assert_equal(Time.milliseconds(1000), Time.seconds(1))
end


if is_main() then 
  UnitTest.run()
end
