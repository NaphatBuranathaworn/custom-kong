local typedefs = require 'kong.db.schema.typedefs'

return {
  name = 'lua-custom-key',
  fields = {
    { protocols = typedefs.protocols },
    { config = {
        type = 'record',
        fields = {
          { key_header = { type = 'string',required = true} },
          { separator = { type = 'string'} },
        },
      },
    },
  },
}