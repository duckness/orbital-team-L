var gulp = require('gulp');
var browserSync = require('browser-sync');
var shell = require('gulp-shell');
var wait = require('gulp-wait');
var paths = {
  cssAssets:'app/assets/stylesheets/*.scss',
  jsAssets: 'app/assets/javascripts/*.coffee',
  erb:     ['app/views/**/*.erb', 'app/**/*.rb'],
  cssF:     'public/assets/application.css',
  jsF:      'public/assets/application.js'
}

// Point to rails server
gulp.task('browser-sync', function() {
  browserSync.init(null, {
    proxy: "192.168.1.135:3000"
  });
});

// for css
gulp.task('css', function () {
  gulp.src(paths.cssF)
  .pipe(shell([ 
    'rake assets:precompile'
  ]))
  .pipe(wait(3000))
  .pipe(browserSync.reload({stream:true}));
});

// for JS
gulp.task('js', function () {
  gulp.src(paths.jsF)
  .pipe(shell([ 
    'rake assets:precompile'
  ]))
  .pipe(wait(3000))
  .pipe(browserSync.reload({stream:true, once: true}));
});

// Reload all Browsers (html)
gulp.task('bs-reload', function () {
  browserSync.reload();
});

gulp.task('default', ['browser-sync'], function () {
  gulp.watch(paths.cssAssets, ['css']);
  gulp.watch(paths.jsAssets, ['js']);
  gulp.watch(paths.erb, ['bs-reload']);
});
