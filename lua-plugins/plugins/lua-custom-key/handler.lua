local BasePlugin = require 'kong.plugins.base_plugin'
local json = require 'rapidjson'

local kong = kong

local CustomKeyHandler = BasePlugin:extend()

function CustomKeyHandler:new()
  CustomKeyHandler.super.new(self, 'lua-custom-key')
end


function CustomKeyHandler:access(conf)
  CustomKeyHandler.super.access(self)

  kong.log.info("conf : ", conf.key_header)

 local conf_header = conf.key_header
 local conf_seperator = conf.separator
  local x_api_key = kong.request.get_header('x-api-key')

  if conf_seperator == nil or conf_seperator == '' then
    kong.response.set_header("content-type", "application/json")
    local err_resp = { 
      code = "8888",
      message = "separator is empty" 
    }
    kong.response.exit(500, err_resp)
  end
  kong.service.request.set_header("Custom-Key", x_api_key .. conf_seperator .. conf_header)
  kong.response.set_header("Custom-Key", x_api_key .. conf_seperator .. conf_header)

end


return CustomKeyHandler