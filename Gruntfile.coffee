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
      assets: 'assets/'
      server: 'server/'
      tmp:    'tmp/'

    clean:
      all: [
        '<%= dirs.server %>'
        '<%= dirs.tmp %>'
      ]
      tmp: ['<%= dirs.tmp %>']

    jshint:
      back: ['packages.json']

    coffeelint:
      files: ['Gruntfile.coffee', 'assets/**/*.coffee', 'config/**/*.coffee']
      options:
        no_backticks:
          level: 'warn'
        max_line_length:
          level: 'warn'

    mince:
      dev:
        src: 'app.js'
        include: ['assets/', 'config/dev/']
        dest: '<%= dirs.server %>app.js'
      prod:
        src: 'app.js'
        include: ['assets/', 'config/prod/']
        dest: '<%= dirs.tmp %>app.js'

    uglify:
      options:
        banner: '<%= meta.banner %>'
      dist:
        src: '<%= dirs.tmp %>app.js'
        dest: '<%= dirs.server %>app.js'

    watch:
      files: [
        '<%= coffeelint.files %>'
      ]
      tasks: [
        'jshint'
        'coffeelint'
        'clean:all'
        'mince:' + ENV
      ]

  # Default task.
  grunt.registerTask 'default', [
    'jshint'
    'coffeelint'
    'clean:all'
    'mince:' + ENV
    'clean:tmp'
  ]

  # Deploy task.
  grunt.registerTask 'deploy', [
    'jshint'
    'coffeelint'
    'clean:all'
    'mince:' + ENV
    'jade'
    'copy'
    'uglify'
    'clean:tmp'
  ]
