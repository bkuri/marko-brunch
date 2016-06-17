'use strict'


{load} = require('marko')


class Markompiler
  brunchPlugin: yes
  defaultEnv: '*'
  extension: 'marko'
  staticTargetExtension: 'html'
  type: 'template'

  constructor: (@config) ->
    @config = @config?.plugins?.marko or data: {}
    require('marko/compiler').defaultOptions.writeToDisk = no

  compileStatic: (params) ->
    {data, path} = params

    new Promise (resolve, reject) =>
      try
        resolve load(path, data).renderSync(@config.data)

      catch error
        reject error


module.exports = Markompiler
