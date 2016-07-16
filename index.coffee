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

  constructor: (cfg) ->
    defaults = data: {}, indent_size: 2, pretty: no, watching: cfg.persistent
    @config = Object.assign(defaults, cfg?.plugins?.marko or {})

    reload.enable() if @config.watching
    return

  compileStatic: (params) ->
    {data, path} = params
    {indent_size, pretty} = @config

    return new Promise (resolve, reject) =>
      try
        output = load(path, data).renderSync(@config.data)

        if pretty and (indent_size > 0)
          output = prettyPrint(output, indent_size)

        resolve output

      catch error
        reject error

      finally
        reload.handleFileModified(path) if @config.watching

      return

module.exports = Markompiler
require('marko/compiler').defaultOptions.writeToDisk = no
