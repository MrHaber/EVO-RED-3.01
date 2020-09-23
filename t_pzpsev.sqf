// Who activated the action?
_caller = _this select 1;

// Move them 5m behind the tower.
_worldPos = t_pzpsev modelToWorld [0,-5,0];
_caller setPos [_worldPos select 0, _worldPos select 1, 0];