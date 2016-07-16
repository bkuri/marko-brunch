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

  compileStatic: (params) ->
    {data, path} = params

    return new Promise (resolve, reject) =>
      try
        {production} = @brunch_config.overrides
        deploy = ('production' in @brunch_config.env)
        output = load(path, data).renderSync(@config.data)

        indent = if deploy and production.optimize
          production.plugins?.marko?.indent or 0
        else @config.indent

        resolve if (indent > 0) then prettyPrint(output, indent_size: indent)
        else output

      catch error
        reject error

      finally
        reload.handleFileModified(path) if @brunch_config.persistent

      return

  constructor: (@brunch_config) ->
    defaults = data: {}, indent: if @brunch_config.isProduction then 0 else 2
    @config = Object.assign(defaults, @brunch_config.plugins?.marko or {})

    reload.enable() if @brunch_config.persistent
    return


module.exports = Markompiler
require('marko/compiler').defaultOptions.writeToDisk = no
