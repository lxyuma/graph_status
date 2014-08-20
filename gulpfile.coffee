gulp = require('gulp')
pl = require('gulp-load-plugins')()
mainBowerFiles = require('main-bower-files')
path = require('path')

projectName = "graph_status"
localPort = '8080'

src =
  scripts:   "app/scripts/**/*.js"
  html:      "app/**/*.html"
  styles:    "app/styles/**/*.scss"
  dirStyles: "app/styles/"

dist = 
  dir:      "dist"
  dirJs:    "dist/scripts/"
  dirBower: "dist/scripts/lib/"
  dirCss:   "dist/styles/"
  index:    "index.html"

# build
gulp.task 'hint', ->
  gulp.src(src.scripts)
    .pipe(pl.jshint())
    .pipe(pl.jshint.reporter("default"))

gulp.task 'scripts', ['hint'], ->
  gulp.src([src.scripts ])
    .pipe(pl.uglify())
    .pipe(pl.concat(projectName + ".js"))
    .pipe(gulp.dest(dist.dirJs))
    .pipe(pl.connect.reload())

gulp.task 'bower', ->
  gulp.src(mainBowerFiles())
    .pipe(gulp.dest(dist.dirBower))

gulp.task 'styles', ->
  gulp.src(src.styles)
    .pipe(pl.compass(project: path.join(__dirname, src.dirStyles)))
    .pipe(pl.csso())
    .pipe(pl.concatCss(projectName + ".css"))
    .pipe(gulp.dest(dist.dirCss))
    .pipe(pl.connect.reload())

gulp.task 'html', ->
  gulp.src(src.html)
    .pipe(gulp.dest(dist.dir))
    .pipe(pl.connect.reload())

gulp.task 'build', ['scripts', 'bower', 'styles', 'html']

# server
gulp.task 'connect', ["build"], ->
  pl.connect.server(
    root: dist.dir
    livereload: true
    port: localPort
  )

gulp.task 'server', ['connect'], ->
  gulp.src(dist.dir + "/" + dist.index)
    .pipe(pl.open('', {url: 'http://localhost:' + localPort + '/' + dist.index}))

# watch
gulp.task 'watch', ->
  gulp.watch(src.scripts, ['scripts'])
  gulp.watch(src.styles,  ['styles'])
  gulp.watch(src.html,    ['html'])

# default
gulp.task 'default', ["server", "watch"]

