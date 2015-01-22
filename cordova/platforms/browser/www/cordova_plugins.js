cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/com.dooble.phonertc/www/phonertc.js",
        "id": "com.dooble.phonertc.PhoneRTC",
        "clobbers": [
            "cordova.plugins.phonertc"
        ]
    },
    {
        "file": "plugins/com.dooble.phonertc/src/browser/PhoneRTCProxy.js",
        "id": "com.dooble.phonertc.PhoneRTCProxy",
        "runs": true
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "org.apache.cordova.inappbrowser": "0.5.4",
    "com.dooble.phonertc": "2.0.0"
}
// BOTTOM OF METADATA
});