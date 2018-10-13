var gulp = require('gulp');

// gulp plugins and utils
var gutil = require('gulp-util');
var livereload = require('gulp-livereload');
var postcss = require('gulp-postcss');
var sourcemaps = require('gulp-sourcemaps');
var zip = require('gulp-zip');
var uglify = require('gulp-uglify');
var filter = require('gulp-filter');

// postcss plugins
var autoprefixer = require('autoprefixer');
var colorFunction = require('postcss-color-function');
var cssnano = require('cssnano');
var customProperties = require('postcss-custom-properties');
var easyimport = require('postcss-easy-import');

var swallowError = function swallowError(error) {
    gutil.log(error.toString());
    gutil.beep();
    this.emit('end');
};

gulp.task('build', ['css', 'js'], function (/* cb */) {
    var targetDir = 'dist/';
    var themeName = require('./package.json').name;
    var filename = themeName + '.zip';

    return gulp.src([
        '**',
        '!node_modules', 
        '!node_modules/**',
        '!dist', 
        '!dist/**',
        '!Dockerfile',
        '!.gitignore',
        '!gulpfile.js',
        '!yarn.lock',
        '!travis.yml',
        '!assets/scripts',
        '!assets/scripts/**',
        '!assets/styles',
        '!assets/styles/**'
    ])
        .pipe(gulp.dest(targetDir));
});

gulp.task('js', function () {
    var jsFilter = filter(['**/*.js'], {restore: true});

    return gulp.src('assets/scripts/**/*.js')
        .on('error', swallowError)
        .pipe(sourcemaps.init())
        .pipe(jsFilter)
        .pipe(uglify())
        .pipe(jsFilter.restore)
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest('dist/assets/scripts'))
        .pipe(livereload());
});

gulp.task('css', function () {
    var processors = [
        easyimport,
        customProperties,
        colorFunction(),
        autoprefixer({browsers: ['last 2 versions']}),
        cssnano()
    ];

    return gulp.src('assets/styles/**/*.css')
        .on('error', swallowError)
        .pipe(sourcemaps.init())
        .pipe(postcss(processors))
        .pipe(sourcemaps.write('.'))
        .pipe(gulp.dest('dist/assets/styles'))
        .pipe(livereload());
});


gulp.task('default', ['build'], function () {
});