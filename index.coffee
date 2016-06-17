'use strict'


{load} = require('marko')
{prettyPrint} = require('html')


class Markompiler
  brunchPlugin: yes
  defaultEnv: '*'
  extension: 'marko'
  staticTargetExtension: 'html'
  type: 'template'

  constructor: (@config) ->
    defaults = data: {}, indent_size: 2, pretty: no
    @config = Object.assign(defaults, @config?.plugins?.marko or {})
    require('marko/compiler').defaultOptions.writeToDisk = no

  compileStatic: (params) ->
    {data, path} = params

    new Promise (resolve, reject) =>
      try
        {indent_size, pretty} = @config

        output = load(path, data).renderSync(@config.data)
        output = prettyPrint(output, @config.indent_size) if pretty and (indent_size > 0)
        resolve output

      catch error
        reject error


module.exports = Markompiler
