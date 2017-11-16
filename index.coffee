'use strict'

{ load } = require('marko')
{ prettyPrint } = require('html')

class Markompiler
  brunchPlugin: yes
  defaultEnv: '*'
  extension: 'marko'
  path: ''
  staticTargetExtension: 'html'
  type: 'template'

  compileStatic: (params) ->
    { data, path } = params

    return new Promise (resolve, reject) =>
      try
        { production } = @brunch_config.overrides
        output = load(path, data).renderSync(@config.data)

        indent_size = switch
          when (@deploy and production.optimize)
            production.plugins?.marko?.indent or 0
          else @config.indent

        resolve switch
          when (indent_size > 0) then prettyPrint(output, { indent_size })
          else output

      catch error
        reject error

      finally
        @reload.handleFileModified(path) if @brunch_config.persistent

      return

  constructor: (@brunch_config) ->
    @deploy = ('production' in @brunch_config.env)
    defaults = data: {}, indent: if @deploy then 0 else 2
    @config = Object.assign(defaults, @brunch_config.plugins?.marko or {})
    return unless @brunch_config.persistent

    @reload = require('marko/hot-reload')
    @reload.enable()
    return


module.exports = Markompiler
require('marko/compiler').defaultOptions.writeToDisk = no
