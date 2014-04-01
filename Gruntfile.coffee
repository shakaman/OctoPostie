# global module:false require:true
path = require 'path'

module.exports = (grunt) ->

  # Load tasks
  require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks)

  ENVS = ['dev', 'test', 'prod']
  ENV = grunt.option('env') || ENVS[0]

  if ENVS.indexOf(ENV) is -1
    grunt.fatal('The environment variable ' + ENV + ' is not supported.')

  grunt.log.writeln ('*******************************************'.green)
  grunt.log.writeln ('**             OctoPostie                **'.green)
  grunt.log.writeln ('**                                       **'.green)
  grunt.log.writeln grunt.log.table([3, 13, 25, 2], ['**'.green, 'Environment: ', ENV.green, '**'.green])
  grunt.log.writeln ('*******************************************'.green)


  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    env: ENV
    meta:
      banner: '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %> - Copyright shakaman (c) */\n'

    dirs:
      src:  'src/'
      dist: 'dist/'
      test:  'test/'
      tmp:  'tmp/'

    clean:
      all: [
        '<%= dirs.dist %>'
        '<%= dirs.tmp %>'
      ]
      test: ['<%= dirs.tmp %>/*']

    jshint:
      back: ['packages.json']

    coffeelint:
      files: ['Gruntfile.coffee', '<%= dirs.src %>/**/*.coffee', '<%= dirs.test %>/**/*.coffee']
      options:
        no_backticks:
          level: 'warn'
        max_line_length:
          level: 'ignore'

    coffee:
      app:
        expand: true
        cwd: '<%= dirs.src %>'
        src: ['**/*.coffee']
        dest: '<%= dirs.dist %>'
        ext: '.js'
      test:
        expand: true
        cwd: '<%= dirs.src %>'
        src: ['**/*.coffee']
        dest: '<%= dirs.tmp %>'
        ext: '.js'


    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: 'coffee-script/register'
      src: ['test/**/*.coffee']

    watch:
      files: [
        '<%= coffeelint.files %>'
      ]
      tasks: [
        'jshint'
        'coffeelint'
        'coffee'
        'test'
      ]

  # Default task.
  grunt.registerTask 'default', [
    'jshint'
    'coffeelint'
    'coffee'
  ]

  # Test task.
  grunt.registerTask 'test', [
    'coffee:test'
    'mochaTest'
    'clean:test'
  ]
