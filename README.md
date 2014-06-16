# Cluttered by team L
This site is currently being built as a project for [NUS Orbital 2014](http://orbital.comp.nus.edu.sg). It is built with Ruby on Rails.

- [Project definition](http://duckness.github.io/orbital-team-L/)
- [Project site](http://clutte.red)


## Installation
You will need the following tools: postgresql, ruby rvm and rails, git, nodeJS, gulpJS, and git.
Now you can clone the project to your PC.
```
git clone https://github.com/duckness/orbital-team-L.git
```

### Rails setup
* Install the gems in the directory:
```sh
bundle install
```
* create a database.yml file

* you may want to precompile the assets files
```sh
rake assets:precompile
```

### Browser-sync for testing
* Install browser-sync
```sh
npm install browser-sync --save-dev
```
* Then you can start the rails server
```sh
rails s
```
* Which BS will use. Type:
```sh
gulp
```
and you're done.
