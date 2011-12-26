require({
    paths: {
        cs: 'require-plugins/cs',
        order: 'require-plugins/order',
        domReady: 'require-plugins/domReady',
        jquery: 'main/jquery',
        underscore: 'main/underscore',
        backbone: 'main/backbone',
        tabbar: 'cs!src/tabbar',
        panel: 'src/panel',
        stage: 'src/stage'
    }
  }, [
    //dependancies
    'order!main/touch',
    'order!underscore',
    'order!backbone',
    'order!cs!main/gfx/gfx',
    'cs!bootstrap'
  ]
);
