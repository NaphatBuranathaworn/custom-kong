local typedefs = require 'kong.db.schema.typedefs'

return {
  name = 'lua-custom-key',
  fields = {
    { protocols = typedefs.protocols },
    { config = {
        type = 'record',
        fields = {
          { prefix = { type = 'string',required = true} },
          { separator = { type = 'string'} },
        },
      },
    },
  },
}