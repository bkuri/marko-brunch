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


  compileStatic: (params) ->
    {data, path} = params
    {indent_size, pretty} = @config

    new Promise (resolve, reject) =>
      try
        output = load(path, data).renderSync(@config.data)
        output = prettyPrint(output, @config.indent_size) if pretty and (indent_size > 0)
        @path = path

        resolve output

      catch error
        reject error


  onCompile: =>
    reload.handleFileModified @path
    @path = ''


module.exports = Markompiler
require('marko/compiler').defaultOptions.writeToDisk = no
reload.enable()
