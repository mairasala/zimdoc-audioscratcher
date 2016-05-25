module.exports = (grunt)->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    bower:
      install :
        options :
          targetDir : 'vendor/bower_components'
          layout : 'byType'
          verbose: true
          copy: true
    concat:
      dist:
        src: ['tmp/precompiled/js/**.js'],
        dest: 'www/js/built.js',
    browserify :
      vendors :
        files :  'www/js/requires.js' : ['src/js/requires.js'] 
    watch:
      coffee:
        files: ['src/js/**/*.coffee']
        tasks: ['coffee']
      concat:
        files: ['tmp/precompiled/js/*.js']
        tasks: ['concat:dist']
      html:
        files: ['src/index.html']
        tasks: ['copy']
    coffee:
      compile:
        files:
          'tmp/precompiled/js/scripts.js': ['src/js/**/*.coffee'] # compile and concat into single file
    copy:
      main:
        expand: true
        cwd: 'src/'
        src: ['*.html']
        dest: 'www/'
    'http-server':
      dev:
        root: 'www/'
        port: 8080
        host: '0.0.0.0'
        showDir: true
        autoIndex: true
        ext: 'html'
        runINBackground: true
        openBrowser: false

  
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-browserify'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-http-server'
  grunt.registerTask 'default',['bower:install','copy','coffee','concat','browserify:vendors','watch']
  grunt.registerTask 'jsfiles',['coffee','concat','browserify:vendors']
