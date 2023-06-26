local package_name = 'lua-plugins'
local package_version = '0.1.0'
local rockspec_revision = '1'

package = package_name
version = package_version .. '-' .. rockspec_revision
supported_platforms = { 'linux', 'macosx' }

source = {
   url = ''
}

description = {
  summary = 'Kong is a scalable and customizable API Management Layer built on top of Nginx.',
  license = 'Apache License Version 2',
}

dependencies = {
  'lua-resty-rsa = 1.1.0-1',
  'lua-resty-nettle',
  'lua-resty-env',
  'luasodium',
  'rapidjson'
}

build = {
  type = 'builtin',
  modules = {
    ['kong.plugins.lua-custom-key.handler'] = 'plugins/lua-custom-key/handler.lua',
    ['kong.plugins.lua-custom-key.schema'] = 'plugins/lua-custom-key/schema.lua',
  }
}