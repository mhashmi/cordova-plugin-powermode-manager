var cordova = require('cordova');
var exec = require('cordova/exec');

var PowerModeManager = function() {
  this.channels = {
    onpowermodechange: cordova.addWindowEventHandler('onpowermodechange'),
  };
  for (var key in this.channels) {
    this.channels[key].onHasSubscribersChange = PowerModeManager.onHasSubscribersChange;
  }
}

PowerModeManager.onHasSubscribersChange = function () {
  if (this.numHandlers === 1 && powerModeManager.channels.onpowermodechange.numHandlers === 1) {
      exec(powerModeManager._status, powerModeManager._error, 'PowerModeManager', 'start', []);
  } else if (handlers() === 0) {
      exec(null, null, 'PowerModeManager', 'stop', []);
  }
};

PowerModeManager.isLowPowerEnabled = function(callback) {
  exec(callback, powerModeManager._error, 'PowerModeManager', 'getPowerMode', []);
}

PowerModeManager.prototype._status = function (info) {
  if (!info) return;
  cordova.fireWindowEvent('onpowermodechange', info);
};

PowerModeManager.prototype._getPowerMode = function (info) {
  if (!info) return;
  cordova.fireWindowEvent('onpowermodechange', info);
};

PowerModeManager.prototype._error = function(err) {
  console.log('Error initializing Power Manager:', err)
}

var powerModeManager = new PowerModeManager();

module.exports = PowerModeManager;
