({
    appDir: '.',
    baseUrl: 'lib',
    //Uncomment to turn off uglify minification.
    //optimize: 'none',
    dir: 'build',
    paths: {
        cs: 'require-plugins/cs',
        order: 'require-plugins/order',
        domReady: 'require-plugins/domReady',
        jquery: 'main/jquery',
        underscore: 'main/underscore',
        backbone: 'main/backbone'
    },
    //This pragma excludes the CoffeeScript compiler code
    //from the optimized source, since all CoffeeScript files
    //are converted and inlined into the main.js built file.
    //If you still want to allow dynamic loading of CoffeeScript
    //files after a build, comment out the pragmasOnSave section.
    pragmasOnSave: {
      // comment this out during development
      excludeCoffeeScript: true
    },
    modules: [
        {
            name: "main"
        }
    ]
})
