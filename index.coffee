'use strict'

{load} = require('marko')
{prettyPrint} = require('html')
reload = require('marko/hot-reload')

class Markompiler
  brunchPlugin: yes
  defaultEnv: '*'
  extension: 'marko'
  path: ''
  staticTargetExtension: 'html'
  type: 'template'

  constructor: (@config) ->
    defaults = data: {}, indent_size: 2, pretty: no
    @config = Object.assign(defaults, @config?.plugins?.marko or {})

    reload.enable()
    return

  compileStatic: (params) ->
    {data, path} = params
    {indent_size, pretty} = @config

    return new Promise (resolve, reject) =>
      try
        output = load(path, data).renderSync(@config.data)

        if pretty and (indent_size > 0)
          output = prettyPrint(output, indent_size)

        reload.handleFileModified path
        resolve output

      catch error
        reject error

      return

module.exports = Markompiler
require('marko/compiler').defaultOptions.writeToDisk = no
