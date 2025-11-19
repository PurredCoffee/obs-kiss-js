## Requirements
- OBS with obs-websocket enabled (set password in Tools → WebSocket Server). (Not preinstalled on some distributions)
- Node.js v22 compliant js interpreter.

## Quick example
```js
const { OBSWebSocket } = require('../src/index');

// connecting, password optional if not specified in OBS
const obs_ws = new OBSWebSocket();
await obs_ws.connect("ws://localhost:4455", "password123");

// single requests
const settings = await obs_ws.requests.config.getVideoSettings();

// multiple requests
await obs_ws.runBatch([
    obs_ws.requests.config.setVideoSettings(
        settings.fpsNumerator,
        settings.fpsDenominator,
        settings.baseWidth,
        settings.baseHeight,
        settings.outputWidth,
        settings.outputHeight
    ),
    //...
]);

// listen to events
obs_ws.onEvent('CurrentPreviewSceneChanged', (sceneName, sceneUuid) => {
    console.log(sceneName, sceneUuid);
// stop listening to events
}).off();
```