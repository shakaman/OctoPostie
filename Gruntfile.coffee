# global module:false require:true
path = require 'path'

module.exports = (grunt) ->

  # Load tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  ENVS = ['dev', 'prod']
  ENV = grunt.option('env') || ENVS[0]

  if ENVS.indexOf(ENV) is -1
    grunt.fatal('The environment variable ' + ENV + ' is not supported.')

  grunt.log.writeln ('***********************************************'.green)
  grunt.log.writeln ('**             GithubToTrello                **'.green)
  grunt.log.writeln ('**                                           **'.green)
  grunt.log.writeln grunt.log.table([3, 13, 29, 2], ['**'.green, 'Environment: ', ENV.green, '**'.green])
  grunt.log.writeln ('***********************************************'.green)


  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    env: ENV
    meta:
      banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> - Copyright shakaman (c) */\n'

    dirs:
      app:  'app/'
      plugins: 'app/plugins/'
      config: "config/#{ENV}/"
      distApp: 'dist/'
      distPlugins: 'dist/plugins/'
      distConfig: "dist/config/"
      tmp:  'tmp/'

    clean:
      all: [
        '<%= dirs.distApp %>'
        '<%= dirs.tmp %>'
      ]
      tmp: ['<%= dirs.tmp %>']

    jshint:
      back: ['packages.json']

    coffeelint:
      files: ['Gruntfile.coffee', '<%= dirs.app %>/**/*.coffee', 'config/**/*.coffee']
      options:
        no_backticks:
          level: 'warn'
        max_line_length:
          level: 'warn'

    coffee:
      app:
        files:
          '<%= dirs.distApp %>app.js' : '<%= dirs.app %>app.coffee'
      config:
        files:
          '<%= dirs.distConfig %>config.js' : '<%= dirs.config %>config.coffee'
      plugins:
        expand: true
        flatten: true
        cwd: '<%= dirs.plugins %>'
        src: ['*.coffee']
        dest: '<%= dirs.distPlugins %>'
        ext: '.js'

    watch:
      files: [
        '<%= coffeelint.files %>'
      ]
      tasks: [
        'jshint'
        'coffeelint'
        #'clean:all'
        'coffee'
      ]

  # Default task.
  grunt.registerTask 'default', [
    'jshint'
    'coffeelint'
    #'clean:all'
    'coffee'
  ]

  # Deploy task.
  grunt.registerTask 'deploy', [
    'jshint'
    'coffeelint'
    #'clean:all'
    'coffee'
  ]
