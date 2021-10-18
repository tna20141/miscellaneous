const process = require('process');
const path = require('path');
const repl = require('repl');

const libs = {
  '_': 'lodash',
  fp: 'lodash/fp',
  datefns: 'date-fns',
  moment: 'moment',
  mtz: 'moment-timezone',
  Async: 'async',
  uuid: 'node-uuid',
  r: 'ramda',
  s: 'sanctuary',
  Fluture: 'fluture',
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
