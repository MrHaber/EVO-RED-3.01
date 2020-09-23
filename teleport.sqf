// Who activated the action?
_caller = _this select 1;

// Move them 5m behind the MHQ.
_worldPos = mhq1 modelToWorld [0,-6,0];
_caller setPos [_worldPos select 0, _worldPos select 1, 0];