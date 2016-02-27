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
      dev:
        options:
          sourceMap: true
          join: true
        files: [
          src: '<%= project.coffee %>/**/*.coffee'
          dest:'<%= project.app %>/app.js'
        ]
      dev2:
        options:
          join: true
        files: [
          src: 'zserver/**/*.coffee'
          dest:'server/app.js'
        ]
      dist:
        options:
          join: true
        files: [
          src: '<%= project.coffee %>/**/*.coffee'
          dest:'<%= project.app %>/app.js'
        ]
      dist2:
        options:
          join: true
        files: [
          src: 'zserver/**/*.coffee'
          dest:'server/app.js'
        ]

    compass:
      dev:
        options:
          basePath: 'public/'
          outputStyle: 'expanded'
          cssDir: 'assets/css'
          sassDir: "../zpublic/app/"
          imagesDir: 'assets/img'
          javascriptsDir: 'assets/js'
          fontsDir: 'assets/fonts'
      dist:
        options:
          basePath: 'public/'
          cssDir: 'assets/css'
          sassDir: "../zpublic/app/"
          imagesDir: 'assets/img'
          javascriptsDir: 'assets/js'
          fontsDir: 'assets/fonts'
          outputStyle: 'compressed'

    haml:
      dev:
        expand: true
        cwd: 'zpublic'
        src: '**/*.haml'
        dest: 'public'
        ext: '.html'
        flatten: false
      dist:
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
      dist:
        src: ['public/app/app.js', 'server/app.js']

    uglify:
      dev:
        options:
          sourceMapIn: '<%= project.app %>/app.js.map'
          sourceMap: true
          sourceMapName: '<%= project.app %>/app.min.js.map'
        files: [
          src: '<%= project.app %>/app.js'
          dest: '<%= project.app %>/app.min.js'
        ]
      dist:
        files: [
          src: '<%= project.app %>/app.js'
          dest: '<%= project.app %>/app.min.js'
        ]
      dev2:
        files: [
          src: 'server/app.js'
          dest: 'server/app.min.js'
        ]
      dist2:
        files: [
          src: 'server/app.js'
          dest: 'server/app.min.js'
        ]

    watch:
      haml:
        files:['zpublic/**/*.haml']
        tasks: ['haml:dev']
      coffee:
        files: ['<%= project.coffee %>/**/*.coffee']
        tasks: ['coffee:dev', 'coffee:dev2', 'uglify:dev']
      compass:
        files: ['<%= project.sass %>/**/*.sass',
                '<%= project.sass %>/**/*.scss']
        tasks: ['compass:dev']


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
  grunt.registerTask 'default', ['compass:dev','coffee:dev', 'coffee:dev2', 'haml:dev',
                                 'uglify:dev', 'uglify:dev2']
  grunt.registerTask 'selenium', ['shell:selenium']
  grunt.registerTask 'e2e', ['env:test', 'cucumberjs']
  grunt.registerTask 'unit', ['mochaTest:unit']
  grunt.registerTask 'build', ['clean:all', 'compass:dev','coffee:dev', 'coffee:dev2',
                               'haml:dev', 'uglify:dev', 'uglify:dev2']
  grunt.registerTask 'publish', ['clean:all', 'compass:dist', 'coffee:dist', 'coffee:dist2',
                                 'haml:dist', 'uglify:dist', 'uglify:dist2', 'clean:dist']