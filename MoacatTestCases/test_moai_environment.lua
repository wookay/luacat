-- test_moai_environment.lua
--                           wookay.noh at gmail.com 

package.path = package.path .. ";../moacat/?.lua"
require 'moacat'

function test_moai_environment()
  assert_equal({ AppDisplayName = "UNKNOWN", 
    AppID = "UNKNOWN", 
    AppVersion = "UNKNOWN", 
    CPUABI = "UNKNOWN", 
    CacheDirectory = "UNKNOWN", 
    CarrierISOCountryCode = "UNKNOWN", 
    CarrierMobileCountryCode = "UNKNOWN", 
    CarrierMobileNetworkCode = "UNKNOWN", 
    CarrierName = "UNKNOWN", 
    ConnectionType = 0, 
    CountryCode = "UNKNOWN", 
    DevBrand = "UNKNOWN", 
    DevManufacturer = "UNKNOWN", 
    DevModel = "UNKNOWN", 
    DevName = "UNKNOWN", 
    DevProduct = "UNKNOWN", 
    DocumentDirectory = "UNKNOWN", 
    LanguageCode = "UNKNOWN", 
    OSBrand = 2, 
    OSVersion = "UNKNOWN", 
    ResourceDirectory = "UNKNOWN", 
    UDID = "UNKNOWN", 
    ViewSize = 0, 
    isRetinaDisplay = false}, Environment)
end



if is_main() then
  UnitTest.run()
end
