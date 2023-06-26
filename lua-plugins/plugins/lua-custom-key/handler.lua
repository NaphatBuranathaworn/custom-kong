local BasePlugin = require 'kong.plugins.base_plugin'
local CustomKeyHandler = BasePlugin:extend()

function CustomKeyHandler:access(conf)

    local conf_prefix = conf.prefix
    local conf_seperator = conf.separator

    local x_custom_key = kong.request.get_header('x-custom-key')

    if conf_seperator == nil or conf_seperator == '' then
        kong.response.set_header("content-type", "application/json")
        local err_resp = {
            code = "8888",
            message = "separator is empty"
        }
        kong.response.exit(500, err_resp)
    end

    kong.service.request.set_header("Custom-key-kong", conf_prefix .. conf_seperator .. x_custom_key)
    kong.response.set_header("Custom-key-kong", conf_prefix .. conf_seperator .. x_custom_key)
end

return CustomKeyHandler