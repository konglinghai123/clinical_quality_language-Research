{ Library } =  require '../../../lib/cql'
module.exports.Repository = class Repository
  constructor: (@data) ->
    @libraries = for k,v of @data
       v

  resolve: (library,version) ->
    for lib in @libraries
      if lib.library.identifier?.id == library && lib.library.identifier?.version == version
        return new Library(lib,@)