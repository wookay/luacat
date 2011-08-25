package.path = package.path .. ";../luacat/?.lua"
require 'luacat'

function parse_url(url)
  local t = {}
  return t 
end

function parse_params(query)
  local t = {}
  return t
end


function test_parse_url()
  local url = 'http://www.google.com/search?client=safari&rls=en&q=lua&ie=UTF-8&oe=UTF-8'
  local uri = parse_url(url)
  assert_equal('http', uri.scheme)
  assert_equal('www.google.com', uri.host)
  assert_equal('/search', uri.path)
  assert_equal('client=safari&rls=en&q=lua&ie=UTF-8&oe=UTF-8', uri.query)
  local expected = {
    client = 'safari',
    rls = 'en',
    q = 'lua',
    ie = 'UTF-8',
    oe = 'UTF-8',
  }
  assert_equal(expected, parse_params(uri.query))
end


if is_main() then
  UnitTest.run()
end
