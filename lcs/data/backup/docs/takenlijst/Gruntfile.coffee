

module.exports = (grunt) ->

  grunt.initConfig
    smoosher:
      options: { }
      single_target:    'docs/smooshed_file.html': ['uitvoer/t-time/nieuwsbrief/2013/april/index.html']
      #multiple_targets: 'docs/two_smooshed_files.html': ['dev/your_project_file.html', 'dev/another_project_file.html']

      #  grunt.loadTasks 'tasks'

  grunt.loadNpmTasks 'grunt-html-smoosher'
  grunt.registerTask('default', ['smoosher'])
