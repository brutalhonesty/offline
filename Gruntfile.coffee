Path = require('path')
fs = require('fs')

module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    coffee:
      compile:
        expand: true
        flatten: true
        src: ['coffee/*.coffee']
        dest: 'js/'
        ext: '.js'

    watch:
      options:
        atBegin:
          true
      coffee:
        files: ['coffee/*', 'sass/*']
        tasks: ["coffee", "uglify", "compass"]

    uglify:
      dev:
        options:
          compress: false
          mangle: false
          beautify: true
          banner: "/*! <%= pkg.name %> <%= pkg.version %> */\n"
        files:
          'offline.js': ['js/*', '!js/snake.js']
      dist:
        options:
          banner: "/*! <%= pkg.name %> <%= pkg.version %> */\n"
        files:
          'offline.min.js': ['js/*', '!js/snake.js']



    compass:
      dist:
        options:
          sassDir: 'sass'
          cssDir: 'themes'

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-compass'

  grunt.registerTask 'default', ['coffee', 'uglify:dev', 'uglify:dist', 'compass']
