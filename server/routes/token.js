module.exports = function(app) {
  var OpenTok  = require('opentok');
  var Firebase = require('firebase');
  
  var OTKEY, OTSECRET, opentok, sendResponse, urlSessions;

  console.log('env TB_KEY = ' + process.env.TB_KEY);

  console.log('env TB_SECRET = ' + process.env.TB_SECRET);

  console.log('env FB_URI = ' + process.env.FB_URI);

  urlSessions = {};

  OTKEY = process.env.TB_KEY;

  OTSECRET = process.env.TB_SECRET;

  opentok = new OpenTok(OTKEY, OTSECRET);

  sendResponse = function(sessionKey, sessionId, caller_id, recipient_id, res) {
    var sessionRef, data, firebaseUri, token;
    token = opentok.generateToken(sessionId);
    console.log('token = ' + token);
    data = {
      opentok: OTKEY,
      sessionId: sessionId,
      token: token,
      caller_id: caller_id || '',
      recipient_id: recipient_id || ''
    };
    console.log('data = ' + OTKEY + ', ' + sessionId + ', ' + token + ', ' + caller_id || '' + ', ' + recipient_id || '');
    firebaseUri = process.env.FB_URI;
    sessionRef = new Firebase(firebaseUri + 'sessions');
    sessionRef.child(sessionKey).set({
      data: data
    });
    return res.send(200, {
      success: sessionKey
    });
  };

  app.get('/token/:session_id', function(req, res) {
    var caller_id, recipient_id;
    if (req.params.session_id == null) {
      return res.status(500).send({
        err: 'Session Id required.'
      });
    }
    caller_id = req.query.caller_id;
    recipient_id = req.query.recipient_id;
    if (recipient_id == null) {
      return res.send(500, {
        err: 'Missing recipient_id'
      });
    }
    if (urlSessions[req.params.session_id] == null) {
      return opentok.createSession(function(err, session) {
        console.log('creating session');
        if (err) {
          return res.send(500, {
            err: err
          });
        }
        urlSessions[req.params.session_id] = session.sessionId;
        return sendResponse(req.params.session_id, session.sessionId, caller_id, recipient_id, res);
      });
    } else {
      return sendResponse(req.params.session_id, urlSessions[req.params.session_id], caller_id, recipient_id, res);
    }
  });
};