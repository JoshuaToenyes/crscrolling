module.exports = (grunt) ->

  config =

    pkg: (grunt.file.readJSON('package.json'))

    coffeelint:
      options:
        configFile: 'coffeelint.json'
      app: ['src/**/*.coffee']

    coffee:
      options:
        sourceMap: true
      src:
        expand: true,
        flatten: false,
        cwd: 'src',
        src: ['./**/*.coffee'],
        dest: 'tmp/dist',
        ext: '.js'
      test:
        expand: true,
        flatten: false,
        cwd: 'test',
        src: ['./**/*.coffee'],
        dest: 'tmp/test',
        ext: '.js'

    browserify:
      src:
        files:
          'dist/vscroll.js': ['tmp/dist/**/*.js']
        options:
          debug: true
          browserifyOptions:
            debug: true
      test:
        files:
          'test/test.js': ['tmp/test/**/*.js']
        options:
          debug: true
          browserifyOptions:
            debug: true

    watch:
      src:
        files: ['src/**/*.coffee'],
        tasks: ['compile']
        configFiles:
          files: ['Gruntfile.coffee']
          options:
            reload: true
      test:
        files: ['test/**/*.coffee', 'src/**/*.coffee'],
        tasks: ['test']
        configFiles:
          files: ['Gruntfile.coffee']
          options:
            reload: true

    clean:
      all: [
        'dist',
        'src/**/*.js',
        'src/**/*.map',
        'test/**/*.js',
        'test/**/*.map']
      tmp: ['tmp']

    copy:
      maps:
        files: [
          {
            expand: true
            flatten: true
            src: ['tmp/dist/**/*.map']
            dest: 'dist/'
            filter: 'isFile'
          }, {
            expand: true
            flatten: true
            src: ['tmp/test/**/*.map']
            dest: 'test/'
            filter: 'isFile'
          }
        ]

    mocha_phantomjs:
      all: ['test/**/*.html']



  grunt.initConfig(config)
  grunt.loadNpmTasks('grunt-browserify')
  grunt.loadNpmTasks('grunt-coffeelint')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-copy')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-mocha-phantomjs')

  grunt.registerTask('compile', [
    'coffeelint',
    'clean',
    'coffee',
    'browserify'
    'copy:maps'
    'clean:tmp'
    ]);

  grunt.registerTask('test', [
    'compile',
    'mocha_phantomjs'
    ]);
