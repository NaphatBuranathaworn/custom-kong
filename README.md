# Custom Kong

## Kong Plugin Development
1. Create plugin folder at lua-plugins/plugins/lua-my-plugin
3. Register your plugin at lua-plugins/plugins/lua-plugins-0.1.0-1.rockspec

    3.1 Append your plugin to build.modules
    
    ```
    ['kong.plugins.lua-my-plugin.handler'] = 'plugins/lua-my-plugin/handler.lua',
    ['kong.plugins.lua-my-plugin.schema'] = 'plugins/lua-my-plugin/schema.lua'
    ```
    3.2 Append lua dependencies to dependencies
    ```
    dependencies = {
      'lua-resty-rsa',
      'lua-resty-nettle',
      'lua-resty-env',
      'lua-resty-jwt',
      'lua-my-dependency' 
    }
    ```
    Lua dependencies
    https://luarocks.org/


    3.3 Append your plugin name to Dockerfile
    ```
    ENV KONG_PLUGINS=bundled,lua-decrypt,lua-white-list,lua-create-scope,lua-encrypt,lua-validate-scope,lua-registration-grant,lua-decrypt-token,lua-encrypt-token,lua-my-plugin
    ```

    3.4 Append your new ENV to Dockerfile
    ```
    ENV KONG_PLUGINS=bundled,lua-decrypt,lua-white-list,lua-create-scope,lua-encrypt,lua-validate-scope,lua-registration-grant,lua-decrypt-token,lua-encrypt-token,lua-revoke-token
    ```
    
4. Rebuild and test on local machine and Test

    ```
    docker compose build && docker compose down && docker compose up -d && docker logs gateway_kong -f
    ```
5. Lua Plugin development reference

    https://docs.konghq.com/gateway-oss/2.5.x/plugin-development/

    https://docs.konghq.com/gateway-oss/2.5.x/plugin-development/custom-logic/

    https://docs.konghq.com/gateway-oss/2.5.x/plugin-development/plugin-configuration/

    https://docs.konghq.com/gateway-oss/2.5.x/pdk/kong.request/

    https://docs.konghq.com/gateway-oss/2.5.x/pdk/kong.service.response/

