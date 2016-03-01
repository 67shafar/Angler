path = require 'path'

module.exports = (grunt)->

  seleniumPath = path.resolve './node_modules/protractor/selenium'

  grunt.initConfig

    project:
      app: 'public/app'
      coffee: 'zpublic/app'
      sass: 'zpublic/app'
      assets: 'public/assets'
      css: '<%= project.assets %>/css'
      js: '<%= project.assets %>/js'
      img: '<%= project.assets %>/img'
      fonts: '<%= project.assets %>/fonts'
      features: 'ztests/features'
      specs: 'ztests/specs'

    env:
      test:
        PATH: "#{seleniumPath}:process.env.PATH"

    pkg: grunt.file.readJSON 'package.json'

    connect:
      server:
        hostname: 'localhost'
        port: 8000
        base: 'public'

    cucumberjs:
      files: '<%= project.features %>/**/*.feature'
      options:
        coffee: true

    shell:
      selenium:
        command: './node_modules/protractor/bin/webdriver-manager start'
        options:
          stdout: true

    coffee:
      pubDev:
        options:
          sourceMap: true
          join: true
        files: [
          src: '<%= project.coffee %>/**/*.coffee'
          dest:'<%= project.app %>/app.js'
        ]
      srvDev:
        options:
          sourceMap: true
          join: true
        files: [
          src: 'zserver/app/**/*.coffee'
          dest:'server/app.js'
        ]
       pubDist:
        options:
          join: true
        files: [
          src: '<%= project.coffee %>/**/*.coffee'
          dest:'<%= project.app %>/app.js'
        ]
      srvDist:
        options:
          join: true
        files: [
          src: 'zserver/app/**/*.coffee'
          dest:'server/app.js'
        ]
      libDev:
        options:
          sourceMap: true
          join: true
        files: [
          src: 'zserver/lib/**/*.coffee'
          dest:'server/lib.js'
        ]
      libDist:
        options:
          join: true
        files: [
          src: 'zserver/lib/**/*.coffee'
          dest:'server/lib.js'
        ]

    compass:
      pubDev:
        options:
          basePath: 'public/'
          outputStyle: 'expanded'
          cssDir: 'assets/css'
          sassDir: "../zpublic/app/"
          imagesDir: 'assets/img'
          javascriptsDir: 'assets/js'
          fontsDir: 'assets/fonts'
      pubDist:
        options:
          basePath: 'public/'
          cssDir: 'assets/css'
          sassDir: "../zpublic/app/"
          imagesDir: 'assets/img'
          javascriptsDir: 'assets/js'
          fontsDir: 'assets/fonts'
          outputStyle: 'compressed'

    haml:
      pubDev:
        expand: true
        cwd: 'zpublic'
        src: '**/*.haml'
        dest: 'public'
        ext: '.html'
        flatten: false
      pubDist:
        expand: true
        cwd: 'zpublic'
        src: '**/*.haml'
        dest: 'public'
        ext: '.html'
        flatten: false

    clean:
      all:
        src: ['public/app/**/*', 'public/**/*.html', 'public/**/*.js',
              'public/**/*.css', 'public/**/*.map', 'server/**/*.js']
      build:
        src: ['public/**/*.html', 'public/**/*.js', 'public/**/*.css',
              'public/**/*.map', 'server/**/*.js']
      pubDist:
        src: ['public/app/app.js', 'server/app.js', 'server/lib.js']


    uglify:
      pubDev:
        options:
          sourceMapIn: '<%= project.app %>/app.js.map'
          sourceMap: true
          sourceMapName: '<%= project.app %>/app.min.js.map'
        files: [
          src: '<%= project.app %>/app.js'
          dest: '<%= project.app %>/app.min.js'
        ]
      pubDist:
        files: [
          src: '<%= project.app %>/app.js'
          dest: '<%= project.app %>/app.min.js'
        ]
      srvDev:
        files: [
          src: 'server/app.js'
          dest: 'server/app.min.js'
        ]
      srvDist:
        files: [
          src: 'server/app.js'
          dest: 'server/app.min.js'
        ]
      libDist:
        files: [
          src: 'server/lib.js'
          dest: 'server/lib.min.js'
        ]
      libDev:
        files: [
          src: 'server/lib.js'
          dest: 'server/lib.min.js'
        ]

    watch:
      haml:
        files:['zpublic/**/*.haml']
        tasks: ['haml:pubDev']
      coffee:
        files: ['<%= project.coffee %>/**/*.coffee']
        tasks: ['coffee:pubDev', 'coffee:srvDev', 'uglify:pubDev']
      compass:
        files: ['<%= project.sass %>/**/*.sass',
                '<%= project.sass %>/**/*.scss']
        tasks: ['compass:pubDev']


    mochaTest:
      unit:
        options:
          require: 'coffee-script/register'
        src: ['./<%= project.specs %>/**/*.coffee']

  grunt.loadNpmTasks 'grunt-connect'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-cucumber'
  grunt.loadNpmTasks 'grunt-env'
  grunt.loadNpmTasks 'grunt-shell'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.loadNpmTasks 'grunt-contrib-compass'
  grunt.loadNpmTasks 'grunt-contrib-haml'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'server', ['connect:server']
  grunt.registerTask 'default', ['compass:pubDev','coffee:pubDev', 'coffee:srvDev', 'haml:pubDev', 'coffee:libDev'
                                 'uglify:pubDev', 'uglify:srvDev']
  grunt.registerTask 'selenium', ['shell:selenium']
  grunt.registerTask 'e2e', ['env:test', 'cucumberjs']
  grunt.registerTask 'unit', ['mochaTest:unit']
  grunt.registerTask 'build', ['clean:all', 'compass:pubDev','coffee:pubDev', 'coffee:srvDev', 'coffee:libDev'
                               'haml:pubDev', 'uglify:pubDev', 'uglify:srvDev', 'uglify:libDev']
  grunt.registerTask 'publish', ['clean:all', 'compass:pubDist', 'coffee:pubDist', 'coffee:srvDist',
                                 'haml:pubDist', 'uglify:pubDist', 'uglify:srvDist', 'clean:pubDist', 'coffee:libDist'
                                 'uglify:libDist']