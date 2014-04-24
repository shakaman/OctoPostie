# OctoPostie [![Built with Grunt](https://cdn.gruntjs.com/builtwith.png)](http://gruntjs.com/) [![Build Status](https://travis-ci.org/shakaman/OctoPostie.png?branch=master)](https://travis-ci.org/shakaman/OctoPostie) [![Dependency Status](https://david-dm.org/shakaman/OctoPostie.png)](https://david-dm.org/shakaman/OctoPostie) [![devDependency Status](https://david-dm.org/shakaman/OctoPostie/dev-status.png)](https://david-dm.org/shakaman/OctoPostie#info=devDependencies)
================

Simple app to bind github's commit to various services.
You can show payload on https://gist.github.com/gjtorikian/5171861

## Requirements
 * node v0.10

## Installation
 * config: `cp src/config.coffee.example src/config.coffee`
 * install: `npm install -g grunt-cli && npm install && grunt`

## How it works
It's simple: `node server/app.js`

## Plugins
Use your config file to had a plugin..
They are loaded when you run the app. (aka not hot pluged)

### Interface
a plugin must implement a isConcern method regarding the payload

### Trello
Only commit from master branch are process.


## Credits
♡2014 by @shakaman and @chpill. Copying is an act of love. Please copy and share.

Released under the MIT licence
