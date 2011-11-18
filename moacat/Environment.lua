-- Environment.lua
--                           wookay.noh at gmail.com 

require 'luacat'

Environment = {}

local methods = String.split([[
getAppDisplayName
getAppID
getAppVersion
getCacheDirectory
getCarrierISOCountryCode
getCarrierMobileCountryCode
getCarrierMobileNetworkCode
getCarrierName
getConnectionType
getCountryCode
getCPUABI
getDevBrand
getDevName
getDevManufacturer
getDevModel
getDevProduct
getDocumentDirectory
getLanguageCode
getOSBrand
getOSVersion
getResourceDirectory
getUDID
getViewSize
isRetinaDisplay
]], LF)

for k,v in pairs(methods) do
  local value = MOAIEnvironment[v]()
  if String.start_with(v, 'get') then
    Environment[String.slice(v, 4, -1)] = value
  else
    Environment[v] = value
  end
end
