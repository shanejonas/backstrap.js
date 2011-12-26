desc 'dev server'
task :serve do
  sh "bundle exec thin -A file -c ./ -a 0.0.0.0 -p 3000 start"
end

desc 'build requirejs and stylus'
task :build do
  sh "rm -rf build"
  sh "node tools/r.js -o build.js"
  sh "stylus stylesheets --out build/stylesheets"
end

desc 'watch stylus'
task :watch do
  sh "stylus --watch stylesheets --out build/stylesheets"
end
