const process = require('process');
const path = require('path');
const repl = require('repl');

const libs = {
  '_': 'lodash',
  moment: 'moment',
  mtz: 'moment-timezone',
  async: 'async',
  uuid: 'node-uuid',
  R: 'ramda',
};

const builtins = {
  util: 'util',
  cp: 'child_process',
};

const consl = repl.start('> ');

Object.keys(libs).forEach(name => {
  consl.context[name] = require(path.join(process.cwd(), 'node_modules', libs[name]));
});

Object.keys(builtins).forEach(name => {
  consl.context[name] = require(builtins[name]);
});
