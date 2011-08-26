-- test_parse_url.lua
--                           


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


function test_parse_simple_url()
  local url = "http://google.com"
  local uri = parse_url(url)
  assert_equal("http", uri.scheme)
  assert_equal("google.com", uri.host)
  assert_equal("", uri.path)
  assert_equal(nil, uri.query)
end

function test_parse_google_search_url()
  local url = "http://www.google.com/search?client=safari&rls=en&q=lua&ie=UTF-8&oe=UTF-8"
  local uri = parse_url(url)
  assert_equal("http", uri.scheme)
  assert_equal("www.google.com", uri.host)
  assert_equal("/search", uri.path)
  assert_equal("client=safari&rls=en&q=lua&ie=UTF-8&oe=UTF-8", uri.query)
  local expected = {
    client = "safari",
    rls = "en",
    q = "lua",
    ie = "UTF-8",
    oe = "UTF-8",
  }
  assert_equal(expected, parse_params(uri.query))
end


function test_parse_file_path()
  local url = "file:///Applications/App%20Store.app/Contents/Resources/Offline/index.html"
  local uri = parse_url(url)
  assert_equal('file', uri.scheme)
  assert_equal(nil, uri.host)
  assert_equal("/Applications/App%20Store.app/Contents/Resources/Offline/index.html", uri.path)
  assert_equal(nil, uri.query)
end

if is_main() then
  UnitTest.run()
end
