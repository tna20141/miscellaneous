function F(val) {
  console.log('F');

  // this will cause error as .then() will be called on this synchronously
  // return 'dd';

  // the callback is executed synchronously, but probably wrapped within caretaking code...
  return new Promise(function(resolve, reject) {
    console.log('P');

    // ... so that this exception is caught (and relayed down the chain)
    // throw 'P ex';

    setTimeout(function() {
      console.log('P done');

      // not handled, probably like a in normal asynchronous handler
      // throw 'P done ex';

      // return reject();
      return resolve(val);
    }, 1000);
  });
}

function F1(val) {
  console.log('F1');

  // doesn't cause error, just relay the value down the promise chain (also it doesn't break the chain)
  // I believe they check the return value. If it's a promise then attach it to the chain,
  // if it's a value then just resolve.
  // return 'dd';

  // handled and relayed down the chain
  // throw 'F1 ex';

  return new Promise(function(resolve, reject) {
    console.log('P1');

    // synchronous, so it's handled no problem
    // throw 'P1 ex';

    setTimeout(function() {
      console.log('P1 done');

      // not handled, same reason with P
      // throw 'P1 done ex';

      return reject('efg');
      return resolve(val);
    }, 1500);
  });
}

function F2(val) {
  console.log('F2');

  // handled and relayed down the chain, as we're back to promise land (with the inner hidden promises)
  // throw 'F2 ex';

  return new Promise(function(resolve, reject) {
    console.log('P2');
    setTimeout(function() {
      console.log('P2 done');
      // return reject();
      return resolve(val);
    }, 1500);
  });
}

// F('aa').then(function() {
//   return F1('bb');
// }).then(function() {
//   return F2('cc');
// }).then(function(val) {
//   console.log('final: ' + val);
// }, function(err) {
//   console.log('final err: ' + err);
// });

// F('aa').then(F1).then(F2).then(function(val) {
//   console.log('final: ' + val);
// }, function(err) {
//   console.log('final err: ' + err);
// });

// // promises can be thenned multiple times, like forking
// var common = F('aa').then(F1);
// common.then(F2).then((val) => { console.log('1 ' + val); });
// common.then(F1).then((val) => { console.log('2 ' + val); });

// if we don't care about additional processing or customizing then
// then(() => { return F1(); }) is the same as then(F1)


// Example promise wrap with conditions:
//
// Bad (having to declare a new promise and explicitly calling resolve/reject):
function test() {
  return new Promise((resolve, reject) => {
    if (cachedResult) {
      return resolve(cachedResult);
    }

    getResult().then((result) => {
      cachedResult = result;
      return resolve(result);
    }, reject);
  });
}
// Good (promise chain, no need to call resolve/reject):
function test() {
  if (cachedResult) {
    return Promise.resolve(cachedResult);
  }

  return getResult().then((result) => {
    cachedResult = result;
    return result;
  });
}

// for now, you have to indent for every conditional branching,
// unless you want to use tricks

// testing fail chain:
function inside() {
  return Promise.reject().then(() => {
    console.log('inside resolved');
  }).catch(() => {
    console.log('inside rejected');
    // this will cause outside to reject
    // return Promise.reject('inside reject value upward');
    // this will cause outside to resolve
    return Promise.resolve('inside reject value upward');
  });

  // // same if you chain it immediately
  // }).then((e) => {
  //   console.log('inside resolved after with ' + e);
  // }).catch((e) => {
  //   console.log('inside rejected after with ' + e);
  // });

}

function outside() {
  inside().then((e) => {
    console.log('outside resolved with ' + e);
  }).catch((e) => {
    console.log('outside rejected with ' + e);
  });
}

// inside();
outside();
