var gulp = require('gulp');
var browserSync = require('browser-sync');
var sass = require('gulp-sass');

// Point to rails server
gulp.task('browser-sync', function() {
  browserSync.init(null, {
    proxy: "192.168.1.135:3000"
  });
});

// Inject CSS
gulp.task('sass', function () {
  gulp.src('app/assets/stylesheets/*.scss')
  .pipe(sass({includePaths: ['scss']}))
  .pipe(gulp.dest('css'))
  .pipe(browserSync.reload({stream:true}));
});


// Reload all Browsers, for changes in HTML
gulp.task('bs-reload', function () {
  browserSync.reload();
});

// Watch scss AND html files, doing different things with each.
gulp.task('default', ['browser-sync'], function () {
  gulp.watch("*.scss", ['sass']);
  gulp.watch("*.rb", ['bs-reload']);
});
