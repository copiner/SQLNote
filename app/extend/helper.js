// app/extend/helper.js
const moment = require('moment');
exports.relativeTime = time => moment(new Date(time * 1000)).fromNow();


exports.shuffle = (arr) => {
    if(!Array.isArray(arr)) {
        return []
    }

    let m = arr.length;
    while (m) {
        const i = Math.floor(Math.random() * m--);
        [arr[m], arr[i]] = [arr[i], arr[m]];
    }
    return arr;
};


exports.parseInt = (string) => {
  if (typeof string === 'number') return string;
  if (!string) return string;
  return parseInt(string) || 0;
};

const EventEmitter = require('events');

/**
 * A mock Subscriber
 */
exports.Subscriber = class extends EventEmitter {
  constructor() {
    super();

    this._start();
  }

  _start() {
    const interval = Math.random() * 5000 + 5000;
    setTimeout(() => {
      this.emit('changed');
      this._start();
    }, interval);
  }
};
