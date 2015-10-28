'use strict';

var { RNAudioPlayer } = require('react-native').NativeModules;

var React = require('react-native');
var {
    NativeModules,
    NativeAppEventEmitter,
    Platform
    } = React;

var AudioPlayer = {
  play(fileName, config) {
    fileName = Platform.OS === 'ios' ? fileName : fileName.replace(/\.[^/.]+$/, "");
    if(config && config.onend)
    {
      NativeAppEventEmitter.once("AudioPlayerPlayingFinished", config.onend);
    }
    RNAudioPlayer.play(fileName);
  }
};

module.exports = AudioPlayer;
