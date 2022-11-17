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
  local x_api_key = kong.request.get_header('x-api-key')

 kong.response.set_header("Custom-Key", x_api_key .. '.' .. conf_header)

end


return CustomKeyHandler